package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.lobby.vehicleCustomization.data.CustomizationEditedKitPopoverListVO;
   import net.wg.infrastructure.base.SmartPopOverView;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class CustomizationEditedKitPopoverMeta extends SmartPopOverView
   {
       
      
      public var remove:Function;
      
      public var removeAll:Function;
      
      public var setToDefault:Function;
      
      private var _customizationEditedKitPopoverListVO:CustomizationEditedKitPopoverListVO;
      
      public function CustomizationEditedKitPopoverMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         if(this._customizationEditedKitPopoverListVO)
         {
            this._customizationEditedKitPopoverListVO.dispose();
            this._customizationEditedKitPopoverListVO = null;
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
      
      public final function as_setItems(param1:Object) : void
      {
         var _loc2_:CustomizationEditedKitPopoverListVO = this._customizationEditedKitPopoverListVO;
         this._customizationEditedKitPopoverListVO = new CustomizationEditedKitPopoverListVO(param1);
         this.setItems(this._customizationEditedKitPopoverListVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      protected function setItems(param1:CustomizationEditedKitPopoverListVO) : void
      {
         var _loc2_:String = "as_setItems" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
