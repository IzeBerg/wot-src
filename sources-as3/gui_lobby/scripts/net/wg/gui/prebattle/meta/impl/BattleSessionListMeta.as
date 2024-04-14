package net.wg.gui.prebattle.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.prebattle.battleSession.BSListRendererVO;
   import net.wg.infrastructure.base.AbstractWindowView;
   import net.wg.infrastructure.exceptions.AbstractException;
   import scaleform.clik.data.DataProvider;
   
   public class BattleSessionListMeta extends AbstractWindowView
   {
       
      
      public var requestToJoinTeam:Function;
      
      public var getClientID:Function;
      
      private var _dataProviderBSListRendererVO:DataProvider;
      
      public function BattleSessionListMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:BSListRendererVO = null;
         if(this._dataProviderBSListRendererVO)
         {
            for each(_loc1_ in this._dataProviderBSListRendererVO)
            {
               _loc1_.dispose();
            }
            this._dataProviderBSListRendererVO.cleanUp();
            this._dataProviderBSListRendererVO = null;
         }
         super.onDispose();
      }
      
      public function requestToJoinTeamS(param1:Number, param2:Number) : void
      {
         App.utils.asserter.assertNotNull(this.requestToJoinTeam,"requestToJoinTeam" + Errors.CANT_NULL);
         this.requestToJoinTeam(param1,param2);
      }
      
      public function getClientIDS() : Number
      {
         App.utils.asserter.assertNotNull(this.getClientID,"getClientID" + Errors.CANT_NULL);
         return this.getClientID();
      }
      
      public final function as_refreshList(param1:Array) : void
      {
         var _loc5_:BSListRendererVO = null;
         var _loc2_:DataProvider = this._dataProviderBSListRendererVO;
         this._dataProviderBSListRendererVO = new DataProvider();
         var _loc3_:uint = param1.length;
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            this._dataProviderBSListRendererVO[_loc4_] = new BSListRendererVO(param1[_loc4_]);
            _loc4_++;
         }
         this.refreshList(this._dataProviderBSListRendererVO);
         if(_loc2_)
         {
            for each(_loc5_ in _loc2_)
            {
               _loc5_.dispose();
            }
            _loc2_.cleanUp();
         }
      }
      
      protected function refreshList(param1:DataProvider) : void
      {
         var _loc2_:String = "as_refreshList" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
