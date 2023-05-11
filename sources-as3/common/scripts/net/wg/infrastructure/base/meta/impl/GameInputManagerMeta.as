package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.infrastructure.base.BaseDAAPIModule;
   
   public class GameInputManagerMeta extends BaseDAAPIModule
   {
       
      
      public var handleGlobalKeyEvent:Function;
      
      public function GameInputManagerMeta()
      {
         super();
      }
      
      public function handleGlobalKeyEventS(param1:Number, param2:String) : void
      {
         App.utils.asserter.assertNotNull(this.handleGlobalKeyEvent,"handleGlobalKeyEvent" + Errors.CANT_NULL);
         this.handleGlobalKeyEvent(param1,param2);
      }
   }
}
