import { SplitFactory } from '@splitsoftware/splitio';

export default (context, inject) => {
    const factory = SplitFactory({
        core: {
            authorizationKey: 'lvic8m8d71ogsdq66dt9hadolgl636csoblk',
        }
    });
    inject('factory', factory);
}