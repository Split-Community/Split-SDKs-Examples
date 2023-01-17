package asynctask

import (
	"fmt"
	"github.com/splitio/go-toolkit/logging"
	"time"
)

// AsyncTask is a struct that wraps tasks that should run periodically and can be remotely stopped & started,
// as well as making it's status (running/stopped) available.
type AsyncTask struct {
	task     func(l logging.LoggerInterface) error
	name     string
	running  bool
	incoming chan int
	period   int
	onInit   func(l logging.LoggerInterface) error
	onStop   func(l logging.LoggerInterface)
	logger   logging.LoggerInterface
}

const (
	taskMessageStop = iota
	taskMessageWakeup
)

// Start initiates the task. It wraps the execution in a closure guarded by a call to recover() in order
// to prevent the main application from crashin if something goes wrong while the sdk interacts with the backend.
func (t *AsyncTask) Start() {

	if t.running {
		if t.logger != nil {
			t.logger.Warning("Task %s is already running. Aborting new execution.", t.name)
		}
		return
	}
	t.running = true

	go func() {
		defer func() {
			if r := recover(); r != nil {
				t.running = false
				if t.logger != nil {
					t.logger.Error(fmt.Sprintf(
						"AsyncTask %s is panicking! Delaying execution for %d seconds (1 period)",
						t.name,
						t.period,
					))
					t.logger.Error(r)
				}
				time.Sleep(time.Duration(t.period) * time.Second)
			}
		}()

		// If there's an initialization function, execute it
		if t.onInit != nil {
			err := t.onInit(t.logger)
			if err != nil {
				// If something goes wrong during initialization, abort.
				if t.logger != nil {
					t.logger.Error(err.Error())
				}
				return
			}
		}

		// Task execution
		for t.running {
			// Run the wrapped task and handle the returned error if any.
			err := t.task(t.logger)
			if err != nil && t.logger != nil {
				t.logger.Error(err.Error())
			}

			// Wait for either a timeout or an interruption (can be a stop signal or a wake up)
			select {
			case msg := <-t.incoming:
				switch msg {
				case taskMessageStop:
					t.running = false
				case taskMessageWakeup:
				}
			case <-time.After(time.Second * time.Duration(t.period)):
			}
		}

		// Post-execution cleanup
		if t.onStop != nil {
			t.onStop(t.logger)
		}
	}()
}

func (t *AsyncTask) sendSignal(signal int) error {
	select {
	case t.incoming <- signal:
		return nil
	default:
		return fmt.Errorf("Couldn't send message to task %s", t.name)
	}
}

// Stop prevents future executions of the task
func (t *AsyncTask) Stop() error {
	return t.sendSignal(taskMessageStop)
}

// WakeUp interrupts the task's sleep period and resumes execution
func (t *AsyncTask) WakeUp() error {
	return t.sendSignal(taskMessageWakeup)
}

// IsRunning returns true if the task is currently running
func (t *AsyncTask) IsRunning() bool {
	return t.running
}

// NewAsyncTask creates a new task and returns a pointer to it
func NewAsyncTask(
	name string,
	task func(l logging.LoggerInterface) error,
	period int,
	onInit func(l logging.LoggerInterface) error,
	onStop func(l logging.LoggerInterface),
	logger logging.LoggerInterface,
) *AsyncTask {
	t := AsyncTask{
		name:     name,
		task:     task,
		running:  false,
		period:   period,
		onInit:   onInit,
		onStop:   onStop,
		logger:   logger,
		incoming: make(chan int, 10),
	}
	return &t
}
