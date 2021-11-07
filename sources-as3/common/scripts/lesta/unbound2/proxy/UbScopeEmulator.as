package lesta.unbound2.proxy
{
   import flash.utils.Proxy;
   import flash.utils.flash_proxy;
   
   public dynamic class UbScopeEmulator extends Proxy
   {
       
      
      private var m_dataProvider:UbDataProviderProxy;
      
      public function UbScopeEmulator(param1:UbDataProviderProxy)
      {
         super();
         this.m_dataProvider = param1;
      }
      
      public function destructorCalledByUnbound() : void
      {
         this.m_dataProvider = null;
      }
      
      override flash_proxy function getProperty(param1:*) : *
      {
         return this.m_dataProvider.p_getScopeProperty(param1);
      }
      
      override flash_proxy function setProperty(param1:*, param2:*) : void
      {
         this.m_dataProvider.p_setScopeProperty(param1,param2);
      }
      
      override flash_proxy function callProperty(param1:*, ... rest) : *
      {
         return null;
      }
      
      public function dispatch(param1:String, param2:Object = null) : void
      {
         this.m_dataProvider.dispatchScopeEvent(param1,param2);
      }
   }
}
