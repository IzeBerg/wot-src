package net.wg.gui.lobby.missions
{
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.geom.ColorTransform;
   import net.wg.data.constants.Linkages;
   import net.wg.gui.components.advanced.interfaces.IDummy;
   import net.wg.gui.components.advanced.vo.DummyVO;
   import net.wg.gui.components.containers.GFWrapper;
   import net.wg.gui.components.controls.UILoaderAlt;
   
   public class MissionsMultipleGFContainerView extends MissionsViewBase
   {
      
      private static const INV_DUMMY:String = "InvDummy";
       
      
      private var _wrapper:GFWrapper = null;
      
      public function MissionsMultipleGFContainerView()
      {
         super();
         alpha = 0;
         bgLoader = new UILoaderAlt();
         bgLoader.transform.colorTransform = new ColorTransform(0.35,0.35,0.35,1,0,0,0,0);
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
      
      override public function as_hideDummy() : void
      {
         var _loc1_:DisplayObject = null;
         super.as_hideDummy();
         this.removeChild(bgLoader);
         if(dummy)
         {
            _loc1_ = dummy as DisplayObject;
            if(_loc1_.parent == this)
            {
               this.removeChild(_loc1_);
            }
         }
      }
      
      public function as_showView() : void
      {
         super.handleShow();
      }
      
      override protected function handleShow() : void
      {
         if(_hasBeenShownBefore)
         {
            super.handleShow();
         }
      }
      
      override protected function setDummyVisible(param1:Boolean) : void
      {
         super.setDummyVisible(param1);
         if(this._wrapper)
         {
            this._wrapper.visible = !param1;
         }
      }
      
      override protected function onDispose() : void
      {
         this._wrapper = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(INV_DUMMY) && dummy)
         {
            this.addChild(bgLoader);
            this.addChild(dummy as DisplayObject);
         }
      }
      
      override protected function showDummy(param1:DummyVO) : void
      {
         if(!dummy)
         {
            dummy = App.utils.classFactory.getComponent(Linkages.DUMMY_UI,IDummy);
            iniDummy();
         }
         super.showDummy(param1);
         invalidateSize();
         invalidate(INV_DUMMY);
      }
      
      override protected function updateBgLoaderSize(param1:int, param2:int) : void
      {
         super.updateBgLoaderSize(param1,param2);
         bgLoader.y = 0;
      }
      
      private function addGFWrapper(param1:DisplayObject) : DisplayObject
      {
         if(this._wrapper == null)
         {
            this._wrapper = GFWrapper(param1);
            this._wrapper.allowOnlyLMBClick = true;
            this._wrapper.setSize(width,height);
            this._wrapper.visible = !dummy || !dummy.visible;
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
