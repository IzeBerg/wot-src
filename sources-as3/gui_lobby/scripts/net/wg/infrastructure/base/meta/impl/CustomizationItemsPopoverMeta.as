package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.lobby.vehicleCustomization.data.CustomizationItemPopoverHeaderVO;
   import net.wg.infrastructure.base.SmartPopOverView;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class CustomizationItemsPopoverMeta extends SmartPopOverView
   {
       
      
      public var remove:Function;
      
      public var removeAll:Function;
      
      public var showOnlyNonHistoric:Function;
      
      private var _customizationItemPopoverHeaderVO:CustomizationItemPopoverHeaderVO;
      
      public function CustomizationItemsPopoverMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         if(this._customizationItemPopoverHeaderVO)
         {
            this._customizationItemPopoverHeaderVO.dispose();
            this._customizationItemPopoverHeaderVO = null;
         }
         super.onDispose();
      }
      
      public function removeS(param1:int, param2:Object) : void
      {
         App.utils.asserter.assertNotNull(this.remove,"remove" + Errors.CANT_NULL);
         this.remove(param1,param2);
      }
      
      public function removeAllS() : void
      {
         App.utils.asserter.assertNotNull(this.removeAll,"removeAll" + Errors.CANT_NULL);
         this.removeAll();
      }
      
      public function showOnlyNonHistoricS(param1:Boolean) : void
      {
         App.utils.asserter.assertNotNull(this.showOnlyNonHistoric,"showOnlyNonHistoric" + Errors.CANT_NULL);
         this.showOnlyNonHistoric(param1);
      }
      
      public final function as_setHeaderData(param1:Object) : void
      {
         var _loc2_:CustomizationItemPopoverHeaderVO = this._customizationItemPopoverHeaderVO;
         this._customizationItemPopoverHeaderVO = new CustomizationItemPopoverHeaderVO(param1);
         this.setHeaderData(this._customizationItemPopoverHeaderVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      protected function setHeaderData(param1:CustomizationItemPopoverHeaderVO) : void
      {
         var _loc2_:String = "as_setHeaderData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
