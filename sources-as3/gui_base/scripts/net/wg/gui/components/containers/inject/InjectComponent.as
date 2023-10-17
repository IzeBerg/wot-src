package net.wg.gui.components.containers.inject
{
   import flash.events.Event;
   import flash.geom.Rectangle;
   import net.wg.data.constants.Errors;
   import net.wg.gui.components.wulf.ChildViewProxy;
   import net.wg.infrastructure.base.meta.IInjectComponentMeta;
   import net.wg.infrastructure.base.meta.impl.InjectComponentMeta;
   
   public class InjectComponent extends InjectComponentMeta implements IInjectComponentMeta
   {
       
      
      private var _proxy:ChildViewProxy = null;
      
      public function InjectComponent()
      {
         super();
         this._proxy = new ChildViewProxy();
         this._proxy.setManageSize(false);
         addChild(this._proxy);
      }
      
      override public function setSize(param1:Number, param2:Number) : void
      {
         App.utils.asserter.assert(!isDisposed(),Errors.CANT_NULL);
         this._proxy.setSize(param1,param2);
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this._proxy.addEventListener(Event.RESIZE,this.onProxyResizeHandler);
      }
      
      override protected function onDispose() : void
      {
         removeChild(this._proxy);
         this._proxy.removeEventListener(Event.RESIZE,this.onProxyResizeHandler);
         this._proxy.dispose();
         this._proxy = null;
         super.onDispose();
      }
      
      public function as_setPlaceId(param1:uint) : void
      {
         this._proxy.placeId = param1;
      }
      
      public function setManageSize(param1:Boolean) : void
      {
         this._proxy.setManageSize(param1);
      }
      
      override public function set visible(param1:Boolean) : void
      {
         if(visible != param1)
         {
            super.visible = param1;
            this._proxy.visible = param1;
         }
      }
      
      override public final function get width() : Number
      {
         return this._proxy.width;
      }
      
      override public function set width(param1:Number) : void
      {
         this._proxy.width = param1;
      }
      
      override public final function get height() : Number
      {
         return this._proxy.height;
      }
      
      override public function set height(param1:Number) : void
      {
         this._proxy.height = param1;
      }
      
      public function get hitRect() : Rectangle
      {
         return this._proxy.hitRect;
      }
      
      private function onProxyResizeHandler(param1:Event) : void
      {
         dispatchEvent(new Event(Event.RESIZE));
      }
   }
}
