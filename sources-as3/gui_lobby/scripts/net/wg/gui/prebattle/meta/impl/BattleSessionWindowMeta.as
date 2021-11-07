package net.wg.gui.prebattle.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.prebattle.abstract.PrebattleWindowAbstract;
   import net.wg.gui.prebattle.battleSession.BSFilterVO;
   import net.wg.gui.prebattle.battleSession.BSFlagRendererVO;
   import net.wg.infrastructure.exceptions.AbstractException;
   import scaleform.clik.data.DataProvider;
   
   public class BattleSessionWindowMeta extends PrebattleWindowAbstract
   {
       
      
      public var requestToAssignMember:Function;
      
      public var requestToUnassignMember:Function;
      
      public var canMoveToAssigned:Function;
      
      public var canMoveToUnassigned:Function;
      
      public var setSelectedFilter:Function;
      
      public var onCantMoveS:Function;
      
      private var _dataProviderBSFlagRendererVO:DataProvider;
      
      private var _vectorBSFilterVO:Vector.<BSFilterVO>;
      
      public function BattleSessionWindowMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:BSFlagRendererVO = null;
         var _loc2_:BSFilterVO = null;
         if(this._dataProviderBSFlagRendererVO)
         {
            for each(_loc1_ in this._dataProviderBSFlagRendererVO)
            {
               _loc1_.dispose();
            }
            this._dataProviderBSFlagRendererVO.cleanUp();
            this._dataProviderBSFlagRendererVO = null;
         }
         if(this._vectorBSFilterVO)
         {
            for each(_loc2_ in this._vectorBSFilterVO)
            {
               _loc2_.dispose();
            }
            this._vectorBSFilterVO.splice(0,this._vectorBSFilterVO.length);
            this._vectorBSFilterVO = null;
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
      
      public function canMoveToAssignedS(param1:Number) : Boolean
      {
         App.utils.asserter.assertNotNull(this.canMoveToAssigned,"canMoveToAssigned" + Errors.CANT_NULL);
         return this.canMoveToAssigned(param1);
      }
      
      public function canMoveToUnassignedS(param1:Number) : Boolean
      {
         App.utils.asserter.assertNotNull(this.canMoveToUnassigned,"canMoveToUnassigned" + Errors.CANT_NULL);
         return this.canMoveToUnassigned(param1);
      }
      
      public function setSelectedFilterS(param1:String) : void
      {
         App.utils.asserter.assertNotNull(this.setSelectedFilter,"setSelectedFilter" + Errors.CANT_NULL);
         this.setSelectedFilter(param1);
      }
      
      public function onCantMoveSS(param1:Number) : void
      {
         App.utils.asserter.assertNotNull(this.onCantMoveS,"onCantMoveS" + Errors.CANT_NULL);
         this.onCantMoveS(param1);
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
      
      public final function as_setFilters(param1:Array, param2:uint) : void
      {
         var _loc6_:BSFilterVO = null;
         var _loc3_:Vector.<BSFilterVO> = this._vectorBSFilterVO;
         this._vectorBSFilterVO = new Vector.<BSFilterVO>(0);
         var _loc4_:uint = param1.length;
         var _loc5_:int = 0;
         while(_loc5_ < _loc4_)
         {
            this._vectorBSFilterVO[_loc5_] = new BSFilterVO(param1[_loc5_]);
            _loc5_++;
         }
         this.setFilters(this._vectorBSFilterVO,param2);
         if(_loc3_)
         {
            for each(_loc6_ in _loc3_)
            {
               _loc6_.dispose();
            }
            _loc3_.splice(0,_loc3_.length);
         }
      }
      
      protected function setNationsLimits(param1:DataProvider) : void
      {
         var _loc2_:String = "as_setNationsLimits" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
      
      protected function setFilters(param1:Vector.<BSFilterVO>, param2:uint) : void
      {
         var _loc3_:String = "as_setFilters" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc3_);
         throw new AbstractException(_loc3_);
      }
   }
}
