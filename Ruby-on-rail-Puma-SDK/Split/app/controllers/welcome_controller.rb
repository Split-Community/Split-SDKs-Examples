require_relative 'splitclient-rb'
require 'SplitSDK'
class WelcomeController < ApplicationController
    def index
        $i = 0
        #        $num = 1000
        #        while $i < $num  do
        tr = SplitSDK.instance
        treatment = tr.getTreatment("testing222", "clients")
        if treatment == "on"
            @msg= "treatment on"
            puts "treatment on"
        elsif treatment == "off"
            @msg= "treatment on"
            puts "treatment on"
        else
            @msg= "control block"
            puts "control block"
        end
            #            $i +=1
            #            @msg="Treatments count: " + $i.to_s
            
            #        end
    end
end
