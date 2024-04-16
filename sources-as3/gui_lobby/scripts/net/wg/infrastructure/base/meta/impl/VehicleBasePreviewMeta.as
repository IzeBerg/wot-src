package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.lobby.vehiclePreview.data.VPAdditionalInfoVO;
   import net.wg.gui.lobby.vehiclePreview.data.VPPageBaseVO;
   import net.wg.infrastructure.base.AbstractView;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class VehicleBasePreviewMeta extends AbstractView
   {
       
      
      public var closeView:Function;
      
      public var onBackClick:Function;
      
      public var onOpenInfoTab:Function;
      
      private var _vPPageBaseVO:VPPageBaseVO;
      
      private var _vPAdditionalInfoVO:VPAdditionalInfoVO;
      
      private var _array:Array;
      
      public function VehicleBasePreviewMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         if(this._vPPageBaseVO)
         {
            this._vPPageBaseVO.dispose();
            this._vPPageBaseVO = null;
         }
         if(this._vPAdditionalInfoVO)
         {
            this._vPAdditionalInfoVO.dispose();
            this._vPAdditionalInfoVO = null;
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
      
      public final function as_setData(param1:Object) : void
      {
         var _loc2_:VPPageBaseVO = this._vPPageBaseVO;
         this._vPPageBaseVO = new VPPageBaseVO(param1);
         this.setData(this._vPPageBaseVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      public final function as_setAdditionalInfo(param1:Object) : void
      {
         var _loc2_:VPAdditionalInfoVO = this._vPAdditionalInfoVO;
         this._vPAdditionalInfoVO = new VPAdditionalInfoVO(param1);
         this.setAdditionalInfo(this._vPAdditionalInfoVO);
         if(_loc2_)
         {
            _loc2_.dispose();
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
      
      protected function setData(param1:VPPageBaseVO) : void
      {
         var _loc2_:String = "as_setData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
      
      protected function setAdditionalInfo(param1:VPAdditionalInfoVO) : void
      {
         var _loc2_:String = "as_setAdditionalInfo" + Errors.ABSTRACT_INVOKE;
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
