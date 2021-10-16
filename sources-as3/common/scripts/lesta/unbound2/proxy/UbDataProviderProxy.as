package lesta.unbound2.proxy
{
   import lesta.unbound2.proxy.base.UbGFxWrapperProxy;
   
   public class UbDataProviderProxy extends UbGFxWrapperProxy
   {
       
      
      public var p_setScopeProperty:Function;
      
      public var p_getScopeProperty:Function;
      
      public var p_dispatchScopeEvent:Function;
      
      private var m_scope:UbScopeEmulator;
      
      public function UbDataProviderProxy()
      {
         super();
         this.m_scope = new UbScopeEmulator(this);
      }
      
      public function init() : void
      {
      }
      
      public function destructorCalledByUnbound() : void
      {
      }
      
      public function get scope() : UbScopeEmulator
      {
         return this.m_scope;
      }
      
      public function setScopeProperty(param1:String, param2:*) : void
      {
         this.p_setScopeProperty(param1,param2);
      }
      
      public function getScopeProperty(param1:String) : *
      {
         return this.p_getScopeProperty(param1);
      }
      
      public function dispatchScopeEvent(param1:String, param2:Object = null) : void
      {
         this.p_dispatchScopeEvent(param1,param2);
      }
   }
}
