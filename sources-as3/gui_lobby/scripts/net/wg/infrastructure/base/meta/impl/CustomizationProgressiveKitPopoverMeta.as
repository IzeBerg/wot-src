package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.lobby.vehicleCustomization.data.CustomizationProgressiveKitPopoverListVO;
   import net.wg.infrastructure.base.SmartPopOverView;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class CustomizationProgressiveKitPopoverMeta extends SmartPopOverView
   {
       
      
      public var remove:Function;
      
      public var removeAll:Function;
      
      public var setToDefault:Function;
      
      public var onFilterChanged:Function;
      
      private var _customizationProgressiveKitPopoverListVO:CustomizationProgressiveKitPopoverListVO;
      
      public function CustomizationProgressiveKitPopoverMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         if(this._customizationProgressiveKitPopoverListVO)
         {
            this._customizationProgressiveKitPopoverListVO.dispose();
            this._customizationProgressiveKitPopoverListVO = null;
         }
         super.onDispose();
      }
      
      public function removeS(param1:int, param2:Object, param3:int) : void
      {
         App.utils.asserter.assertNotNull(this.remove,"remove" + Errors.CANT_NULL);
         this.remove(param1,param2,param3);
      }
      
      public function removeAllS() : void
      {
         App.utils.asserter.assertNotNull(this.removeAll,"removeAll" + Errors.CANT_NULL);
         this.removeAll();
      }
      
      public function setToDefaultS() : void
      {
         App.utils.asserter.assertNotNull(this.setToDefault,"setToDefault" + Errors.CANT_NULL);
         this.setToDefault();
      }
      
      public function onFilterChangedS(param1:Boolean, param2:Boolean, param3:Boolean, param4:Boolean) : void
      {
         App.utils.asserter.assertNotNull(this.onFilterChanged,"onFilterChanged" + Errors.CANT_NULL);
         this.onFilterChanged(param1,param2,param3,param4);
      }
      
      public final function as_setItems(param1:Object) : void
      {
         var _loc2_:CustomizationProgressiveKitPopoverListVO = this._customizationProgressiveKitPopoverListVO;
         this._customizationProgressiveKitPopoverListVO = new CustomizationProgressiveKitPopoverListVO(param1);
         this.setItems(this._customizationProgressiveKitPopoverListVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      protected function setItems(param1:CustomizationProgressiveKitPopoverListVO) : void
      {
         var _loc2_:String = "as_setItems" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
