package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.infrastructure.base.BaseDAAPIModule;
   
   public class SoundManagerMeta extends BaseDAAPIModule
   {
       
      
      public var soundEventHandler:Function;
      
      public function SoundManagerMeta()
      {
         super();
      }
      
      public function soundEventHandlerS(param1:String, param2:String, param3:String, param4:String) : void
      {
         App.utils.asserter.assertNotNull(this.soundEventHandler,"soundEventHandler" + Errors.CANT_NULL);
         this.soundEventHandler(param1,param2,param3,param4);
      }
   }
}
