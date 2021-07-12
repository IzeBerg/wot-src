package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.components.controls.tabs.OrangeTabsMenuVO;
   import net.wg.gui.lobby.vehiclePreview.data.VPPageVO;
   import net.wg.infrastructure.base.AbstractView;
   import net.wg.infrastructure.exceptions.AbstractException;
   import scaleform.clik.data.DataProvider;
   
   public class VehiclePreviewMeta extends AbstractView
   {
       
      
      public var closeView:Function;
      
      public var onBackClick:Function;
      
      public var onOpenInfoTab:Function;
      
      public var onCompareClick:Function;
      
      private var _vPPageVO:VPPageVO;
      
      private var _dataProviderOrangeTabsMenuVO:DataProvider;
      
      private var _array:Array;
      
      public function VehiclePreviewMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:OrangeTabsMenuVO = null;
         if(this._vPPageVO)
         {
            this._vPPageVO.dispose();
            this._vPPageVO = null;
         }
         if(this._dataProviderOrangeTabsMenuVO)
         {
            for each(_loc1_ in this._dataProviderOrangeTabsMenuVO)
            {
               _loc1_.dispose();
            }
            this._dataProviderOrangeTabsMenuVO.cleanUp();
            this._dataProviderOrangeTabsMenuVO = null;
         }
         if(this._array)
         {
            this._array.splice(0,this._array.length);
            this._array = null;
         }
         super.onDispose();
      }
      
      public function closeViewS() : void
      {
         App.utils.asserter.assertNotNull(this.closeView,"closeView" + Errors.CANT_NULL);
         this.closeView();
      }
      
      public function onBackClickS() : void
      {
         App.utils.asserter.assertNotNull(this.onBackClick,"onBackClick" + Errors.CANT_NULL);
         this.onBackClick();
      }
      
      public function onOpenInfoTabS(param1:int) : void
      {
         App.utils.asserter.assertNotNull(this.onOpenInfoTab,"onOpenInfoTab" + Errors.CANT_NULL);
         this.onOpenInfoTab(param1);
      }
      
      public function onCompareClickS() : void
      {
         App.utils.asserter.assertNotNull(this.onCompareClick,"onCompareClick" + Errors.CANT_NULL);
         this.onCompareClick();
      }
      
      public final function as_setData(param1:Object) : void
      {
         var _loc2_:VPPageVO = this._vPPageVO;
         this._vPPageVO = new VPPageVO(param1);
         this.setData(this._vPPageVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      public final function as_setTabsData(param1:Array) : void
      {
         var _loc5_:OrangeTabsMenuVO = null;
         var _loc2_:DataProvider = this._dataProviderOrangeTabsMenuVO;
         this._dataProviderOrangeTabsMenuVO = new DataProvider();
         var _loc3_:uint = param1.length;
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            this._dataProviderOrangeTabsMenuVO[_loc4_] = new OrangeTabsMenuVO(param1[_loc4_]);
            _loc4_++;
         }
         this.setTabsData(this._dataProviderOrangeTabsMenuVO);
         if(_loc2_)
         {
            for each(_loc5_ in _loc2_)
            {
               _loc5_.dispose();
            }
            _loc2_.cleanUp();
         }
      }
      
      public final function as_show3DSceneTooltip(param1:String, param2:Array) : void
      {
         var _loc3_:Array = this._array;
         this._array = param2;
         this.show3DSceneTooltip(param1,this._array);
         if(_loc3_)
         {
            _loc3_.splice(0,_loc3_.length);
         }
      }
      
      protected function setData(param1:VPPageVO) : void
      {
         var _loc2_:String = "as_setData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
      
      protected function setTabsData(param1:DataProvider) : void
      {
         var _loc2_:String = "as_setTabsData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
      
      protected function show3DSceneTooltip(param1:String, param2:Array) : void
      {
         var _loc3_:String = "as_show3DSceneTooltip" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc3_);
         throw new AbstractException(_loc3_);
      }
   }
}
