package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.dialogs.SimpleDialog;
   import net.wg.gui.lobby.dialogs.data.IconPriceDialogVO;
   import net.wg.gui.lobby.tankman.crewSkins.model.CrewSkinVO;
   import net.wg.infrastructure.exceptions.AbstractException;
   import scaleform.clik.data.DataProvider;
   
   public class CrewSkinsCompensationDialogMeta extends SimpleDialog
   {
       
      
      private var _dataProviderCrewSkinVO:DataProvider;
      
      private var _iconPriceDialogVO:IconPriceDialogVO;
      
      public function CrewSkinsCompensationDialogMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:CrewSkinVO = null;
         if(this._dataProviderCrewSkinVO)
         {
            for each(_loc1_ in this._dataProviderCrewSkinVO)
            {
               _loc1_.dispose();
            }
            this._dataProviderCrewSkinVO.cleanUp();
            this._dataProviderCrewSkinVO = null;
         }
         if(this._iconPriceDialogVO)
         {
            this._iconPriceDialogVO.dispose();
            this._iconPriceDialogVO = null;
         }
         super.onDispose();
      }
      
      public final function as_setList(param1:Array) : void
      {
         var _loc5_:CrewSkinVO = null;
         var _loc2_:DataProvider = this._dataProviderCrewSkinVO;
         this._dataProviderCrewSkinVO = new DataProvider();
         var _loc3_:uint = param1.length;
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            this._dataProviderCrewSkinVO[_loc4_] = new CrewSkinVO(param1[_loc4_]);
            _loc4_++;
         }
         this.setList(this._dataProviderCrewSkinVO);
         if(_loc2_)
         {
            for each(_loc5_ in _loc2_)
            {
               _loc5_.dispose();
            }
            _loc2_.cleanUp();
         }
      }
      
      public final function as_setMessagePrice(param1:Object) : void
      {
         var _loc2_:IconPriceDialogVO = this._iconPriceDialogVO;
         this._iconPriceDialogVO = new IconPriceDialogVO(param1);
         this.setMessagePrice(this._iconPriceDialogVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      protected function setList(param1:DataProvider) : void
      {
         var _loc2_:String = "as_setList" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
      
      protected function setMessagePrice(param1:IconPriceDialogVO) : void
      {
         var _loc2_:String = "as_setMessagePrice" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
