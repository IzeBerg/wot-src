package net.wg.gui.components.containers.inject
{
   import flash.display.DisplayObject;
   import flash.events.Event;
   import net.wg.gui.components.containers.BaseContainerWrapper;
   import net.wg.gui.components.containers.GFWrapper;
   import net.wg.infrastructure.base.BaseDAAPIComponent;
   
   public class GFInjectComponent extends BaseDAAPIComponent
   {
       
      
      private var _wrapper:GFWrapper = null;
      
      public function GFInjectComponent()
      {
         super();
      }
      
      override public function addChild(param1:DisplayObject) : DisplayObject
      {
         if(this._wrapper == null && param1.name == GFWrapper.GF_WRAPPER_NAME)
         {
            this._wrapper = GFWrapper(param1);
            this._wrapper.setSize(width,height);
         }
         return super.addChild(param1);
      }
      
      override public function removeChild(param1:DisplayObject) : DisplayObject
      {
         if(this._wrapper != null && param1.name == GFWrapper.GF_WRAPPER_NAME)
         {
            this._wrapper = null;
         }
         return super.removeChild(param1);
      }
      
      override public function setSize(param1:Number, param2:Number) : void
      {
         super.setSize(param1,param2);
         if(this._wrapper != null)
         {
            this._wrapper.setSize(param1,param2);
            this._wrapper.dispatchEvent(new Event(Event.RESIZE));
         }
      }
      
      public function get wrapper() : BaseContainerWrapper
      {
         return this._wrapper;
      }
   }
}
