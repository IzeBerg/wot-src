package net.wg.gui.prebattle.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.prebattle.abstract.PrebattleWindowAbstract;
   import net.wg.gui.prebattle.battleSession.BSFlagRendererVO;
   import net.wg.infrastructure.exceptions.AbstractException;
   import scaleform.clik.data.DataProvider;
   
   public class BattleSessionWindowMeta extends PrebattleWindowAbstract
   {
       
      
      public var requestToAssignMember:Function;
      
      public var requestToUnassignMember:Function;
      
      public var canMoveToAssigned:Function;
      
      public var canMoveToUnassigned:Function;
      
      private var _dataProviderBSFlagRendererVO:DataProvider;
      
      public function BattleSessionWindowMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:BSFlagRendererVO = null;
         if(this._dataProviderBSFlagRendererVO)
         {
            for each(_loc1_ in this._dataProviderBSFlagRendererVO)
            {
               _loc1_.dispose();
            }
            this._dataProviderBSFlagRendererVO.cleanUp();
            this._dataProviderBSFlagRendererVO = null;
         }
         super.onDispose();
      }
      
      public function requestToAssignMemberS(param1:Number) : void
      {
         App.utils.asserter.assertNotNull(this.requestToAssignMember,"requestToAssignMember" + Errors.CANT_NULL);
         this.requestToAssignMember(param1);
      }
      
      public function requestToUnassignMemberS(param1:Number) : void
      {
         App.utils.asserter.assertNotNull(this.requestToUnassignMember,"requestToUnassignMember" + Errors.CANT_NULL);
         this.requestToUnassignMember(param1);
      }
      
      public function canMoveToAssignedS() : Boolean
      {
         App.utils.asserter.assertNotNull(this.canMoveToAssigned,"canMoveToAssigned" + Errors.CANT_NULL);
         return this.canMoveToAssigned();
      }
      
      public function canMoveToUnassignedS() : Boolean
      {
         App.utils.asserter.assertNotNull(this.canMoveToUnassigned,"canMoveToUnassigned" + Errors.CANT_NULL);
         return this.canMoveToUnassigned();
      }
      
      public final function as_setNationsLimits(param1:Array) : void
      {
         var _loc3_:uint = 0;
         var _loc4_:int = 0;
         var _loc5_:BSFlagRendererVO = null;
         var _loc2_:DataProvider = this._dataProviderBSFlagRendererVO;
         this._dataProviderBSFlagRendererVO = new DataProvider();
         if(param1)
         {
            _loc3_ = param1.length;
            _loc4_ = 0;
            while(_loc4_ < _loc3_)
            {
               this._dataProviderBSFlagRendererVO[_loc4_] = new BSFlagRendererVO(param1[_loc4_]);
               _loc4_++;
            }
         }
         this.setNationsLimits(this._dataProviderBSFlagRendererVO);
         if(_loc2_)
         {
            for each(_loc5_ in _loc2_)
            {
               _loc5_.dispose();
            }
            _loc2_.cleanUp();
         }
      }
      
      protected function setNationsLimits(param1:DataProvider) : void
      {
         var _loc2_:String = "as_setNationsLimits" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
