package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.lobby.missions.data.MissionsTokenPopoverVO;
   import net.wg.gui.lobby.missions.data.TokenRendererVO;
   import net.wg.infrastructure.base.SmartPopOverView;
   import net.wg.infrastructure.exceptions.AbstractException;
   import scaleform.clik.data.DataProvider;
   
   public class MissionsTokenPopoverMeta extends SmartPopOverView
   {
       
      
      public var onQuestClick:Function;
      
      public var onBuyBtnClick:Function;
      
      private var _missionsTokenPopoverVO:MissionsTokenPopoverVO;
      
      private var _dataProviderTokenRendererVO:DataProvider;
      
      public function MissionsTokenPopoverMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:TokenRendererVO = null;
         if(this._missionsTokenPopoverVO)
         {
            this._missionsTokenPopoverVO.dispose();
            this._missionsTokenPopoverVO = null;
         }
         if(this._dataProviderTokenRendererVO)
         {
            for each(_loc1_ in this._dataProviderTokenRendererVO)
            {
               _loc1_.dispose();
            }
            this._dataProviderTokenRendererVO.cleanUp();
            this._dataProviderTokenRendererVO = null;
         }
         super.onDispose();
      }
      
      public function onQuestClickS(param1:String) : void
      {
         App.utils.asserter.assertNotNull(this.onQuestClick,"onQuestClick" + Errors.CANT_NULL);
         this.onQuestClick(param1);
      }
      
      public function onBuyBtnClickS() : void
      {
         App.utils.asserter.assertNotNull(this.onBuyBtnClick,"onBuyBtnClick" + Errors.CANT_NULL);
         this.onBuyBtnClick();
      }
      
      public final function as_setStaticData(param1:Object) : void
      {
         var _loc2_:MissionsTokenPopoverVO = this._missionsTokenPopoverVO;
         this._missionsTokenPopoverVO = new MissionsTokenPopoverVO(param1);
         this.setStaticData(this._missionsTokenPopoverVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      public final function as_setListDataProvider(param1:Array) : void
      {
         var _loc5_:TokenRendererVO = null;
         var _loc2_:DataProvider = this._dataProviderTokenRendererVO;
         this._dataProviderTokenRendererVO = new DataProvider();
         var _loc3_:uint = param1.length;
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            this._dataProviderTokenRendererVO[_loc4_] = new TokenRendererVO(param1[_loc4_]);
            _loc4_++;
         }
         this.setListDataProvider(this._dataProviderTokenRendererVO);
         if(_loc2_)
         {
            for each(_loc5_ in _loc2_)
            {
               _loc5_.dispose();
            }
            _loc2_.cleanUp();
         }
      }
      
      protected function setStaticData(param1:MissionsTokenPopoverVO) : void
      {
         var _loc2_:String = "as_setStaticData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
      
      protected function setListDataProvider(param1:DataProvider) : void
      {
         var _loc2_:String = "as_setListDataProvider" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
