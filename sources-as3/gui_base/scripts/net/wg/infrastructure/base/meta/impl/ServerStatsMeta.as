package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.infrastructure.base.BaseDAAPIComponent;
   
   public class ServerStatsMeta extends BaseDAAPIComponent
   {
       
      
      public var relogin:Function;
      
      public var startListenCsisUpdate:Function;
      
      public function ServerStatsMeta()
      {
         super();
      }
      
      public function reloginS(param1:int) : void
      {
         App.utils.asserter.assertNotNull(this.relogin,"relogin" + Errors.CANT_NULL);
         this.relogin(param1);
      }
      
      public function startListenCsisUpdateS(param1:Boolean) : void
      {
         App.utils.asserter.assertNotNull(this.startListenCsisUpdate,"startListenCsisUpdate" + Errors.CANT_NULL);
         this.startListenCsisUpdate(param1);
      }
   }
}
