using ReactNative.Bridge;
using System;
using System.Collections.Generic;
using Windows.ApplicationModel.Core;
using Windows.UI.Core;

namespace Jwt.Generator.RNJwtGenerator
{
    /// <summary>
    /// A module that allows JS to share data.
    /// </summary>
    class RNJwtGeneratorModule : NativeModuleBase
    {
        /// <summary>
        /// Instantiates the <see cref="RNJwtGeneratorModule"/>.
        /// </summary>
        internal RNJwtGeneratorModule()
        {

        }

        /// <summary>
        /// The name of the native module.
        /// </summary>
        public override string Name
        {
            get
            {
                return "RNJwtGenerator";
            }
        }
    }
}
