package net.wg.gui.lobby.missions
{
   import flash.display.DisplayObject;
   import flash.geom.ColorTransform;
   import net.wg.data.constants.Errors;
   import net.wg.data.constants.Linkages;
   import net.wg.gui.components.advanced.interfaces.IDummy;
   import net.wg.gui.components.advanced.vo.DummyVO;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.gui.components.wulf.ChildViewProxy;
   import net.wg.infrastructure.base.meta.IInjectComponentMeta;
   
   public class MissionsMultipleGFContainerView extends MissionsViewBase implements IInjectComponentMeta
   {
      
      private static const INV_DUMMY:String = "InvDummy";
       
      
      private var _proxy:ChildViewProxy = null;
      
      public function MissionsMultipleGFContainerView()
      {
         super();
         alpha = 0;
         this._proxy = new ChildViewProxy();
         this._proxy.setManageSize(true);
         addChild(this._proxy);
         bgLoader = new UILoaderAlt();
         bgLoader.transform.colorTransform = new ColorTransform(0.35,0.35,0.35,1,0,0,0,0);
      }
      
      override public function as_hideDummy() : void
      {
         var _loc1_:DisplayObject = null;
         super.as_hideDummy();
         removeChild(bgLoader);
         if(dummy)
         {
            _loc1_ = dummy as DisplayObject;
            if(_loc1_.parent == this)
            {
               removeChild(_loc1_);
            }
         }
      }
      
      override public function setSize(param1:Number, param2:Number) : void
      {
         App.utils.asserter.assert(!isDisposed(),Errors.CANT_NULL);
         super.setSize(param1,param2);
         this._proxy.setSize(param1,param2);
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
         this._proxy.visible = !param1;
      }
      
      override protected function onDispose() : void
      {
         removeChild(this._proxy);
         this._proxy.dispose();
         this._proxy = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(INV_DUMMY) && dummy)
         {
            addChild(bgLoader);
            addChild(dummy as DisplayObject);
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
      
      public function as_setPlaceId(param1:uint) : void
      {
         this._proxy.placeId = param1;
      }
      
      public function as_showView() : void
      {
         super.handleShow();
      }
   }
}
