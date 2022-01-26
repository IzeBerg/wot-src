package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.lobby.shop.data.RentalTermSelectionPopoverVO;
   import net.wg.infrastructure.base.SmartPopOverView;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class RentalTermSelectionPopoverMeta extends SmartPopOverView
   {
       
      
      public var selectTerm:Function;
      
      private var _rentalTermSelectionPopoverVO:RentalTermSelectionPopoverVO;
      
      public function RentalTermSelectionPopoverMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         if(this._rentalTermSelectionPopoverVO)
         {
            this._rentalTermSelectionPopoverVO.dispose();
            this._rentalTermSelectionPopoverVO = null;
         }
         super.onDispose();
      }
      
      public function selectTermS(param1:int) : void
      {
         App.utils.asserter.assertNotNull(this.selectTerm,"selectTerm" + Errors.CANT_NULL);
         this.selectTerm(param1);
      }
      
      public final function as_setInitData(param1:Object) : void
      {
         var _loc2_:RentalTermSelectionPopoverVO = this._rentalTermSelectionPopoverVO;
         this._rentalTermSelectionPopoverVO = new RentalTermSelectionPopoverVO(param1);
         this.setInitData(this._rentalTermSelectionPopoverVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      protected function setInitData(param1:RentalTermSelectionPopoverVO) : void
      {
         var _loc2_:String = "as_setInitData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
