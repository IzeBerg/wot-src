package net.wg.gui.components.containers
{
   import flash.display.DisplayObject;
   import flash.events.Event;
   import net.wg.infrastructure.base.BaseDAAPIComponent;
   
   public class MultipleGFContainerView extends BaseDAAPIComponent
   {
       
      
      private var _wrapper:GFWrapper = null;
      
      public function MultipleGFContainerView()
      {
         super();
      }
      
      override public function addChild(param1:DisplayObject) : DisplayObject
      {
         if(param1.name == GFWrapper.GF_WRAPPER_NAME)
         {
            return this.addGFWrapper(param1);
         }
         return super.addChild(param1);
      }
      
      override public function removeChild(param1:DisplayObject) : DisplayObject
      {
         if(param1.name == GFWrapper.GF_WRAPPER_NAME)
         {
            return this.removeGFWrapper(param1);
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
      
      override protected function onDispose() : void
      {
         this._wrapper = null;
         super.onDispose();
      }
      
      private function addGFWrapper(param1:DisplayObject) : DisplayObject
      {
         if(this._wrapper == null)
         {
            this._wrapper = GFWrapper(param1);
            this._wrapper.allowOnlyLMBClick = true;
            this._wrapper.setSize(width,height);
         }
         return super.addChild(param1);
      }
      
      private function removeGFWrapper(param1:DisplayObject) : DisplayObject
      {
         if(this._wrapper != null)
         {
            this._wrapper = null;
         }
         return super.removeChild(param1);
      }
   }
}
