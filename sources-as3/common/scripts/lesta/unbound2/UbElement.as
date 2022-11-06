package lesta.unbound2
{
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import lesta.unbound2.proxy.UbElementProxy;
   import lesta.unbound2.proxy.UbPlayerProxy;
   import lesta.unbound2.proxy.base.UbProxyEvent;
   
   public class UbElement extends Sprite
   {
       
      
      private var m_player:UbPlayerProxy;
      
      private var m_elementName:String;
      
      private var m_elementProxy:UbElementProxy;
      
      private var m_view:DisplayObject = null;
      
      public function UbElement(param1:UbPlayerProxy, param2:String, param3:Object)
      {
         super();
         this.m_player = param1;
         this.m_elementName = param2;
         this.m_elementProxy = this.m_player.buildElement(param2,param3);
         if(this.m_elementProxy.view != null)
         {
            addChild(this.m_elementProxy.view);
         }
         this.m_view = this.m_elementProxy.view;
         this.m_elementProxy.addEventListener(UbElementProxy.EVENT_CLEANUP,this.onElementCleanup);
         this.m_elementProxy.addEventListener(UbElementProxy.EVENT_REBUILT,this.onElementRebuilt);
      }
      
      private function onElementCleanup(param1:UbProxyEvent) : void
      {
         if(this.m_view != null)
         {
            removeChild(this.m_view);
         }
         this.m_view = null;
      }
      
      private function onElementRebuilt(param1:UbProxyEvent) : void
      {
         if(this.m_elementProxy.view != null)
         {
            addChild(this.m_elementProxy.view);
         }
         this.m_view = this.m_elementProxy.view;
      }
      
      public function destructorCalledByUnbound() : void
      {
         if(this.m_view != null)
         {
            removeChild(this.m_view);
         }
         this.m_view = null;
         this.m_elementProxy.removeEventListener(UbElementProxy.EVENT_CLEANUP,this.onElementCleanup);
         this.m_elementProxy.removeEventListener(UbElementProxy.EVENT_REBUILT,this.onElementRebuilt);
         this.m_player.destroyElement(this.elementProxy.elementId);
         this.m_elementProxy = null;
         this.m_player = null;
      }
      
      public function get elementProxy() : UbElementProxy
      {
         return this.m_elementProxy;
      }
      
      public function get elementName() : String
      {
         return this.m_elementName;
      }
   }
}
