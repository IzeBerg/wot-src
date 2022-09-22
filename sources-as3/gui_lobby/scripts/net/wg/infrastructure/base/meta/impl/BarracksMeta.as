package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.VO.CountersVo;
   import net.wg.data.constants.Errors;
   import net.wg.gui.lobby.barracks.data.BarracksTankmenVO;
   import net.wg.infrastructure.base.AbstractView;
   import net.wg.infrastructure.exceptions.AbstractException;
   import scaleform.clik.data.DataProvider;
   
   public class BarracksMeta extends AbstractView
   {
       
      
      public var invalidateTanksList:Function;
      
      public var setFilter:Function;
      
      public var onShowRecruitWindowClick:Function;
      
      public var actTankman:Function;
      
      public var buyBerths:Function;
      
      public var closeBarracks:Function;
      
      public var setTankmenFilter:Function;
      
      public var openPersonalCase:Function;
      
      public var onCountersVisited:Function;
      
      private var _barracksTankmenVO:BarracksTankmenVO;
      
      private var _dataProvider:DataProvider;
      
      private var _vectorCountersVo:Vector.<CountersVo>;
      
      public function BarracksMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:CountersVo = null;
         if(this._barracksTankmenVO)
         {
            this._barracksTankmenVO.dispose();
            this._barracksTankmenVO = null;
         }
         if(this._dataProvider)
         {
            this._dataProvider.cleanUp();
            this._dataProvider = null;
         }
         if(this._vectorCountersVo)
         {
            for each(_loc1_ in this._vectorCountersVo)
            {
               _loc1_.dispose();
            }
            this._vectorCountersVo.splice(0,this._vectorCountersVo.length);
            this._vectorCountersVo = null;
         }
         super.onDispose();
      }
      
      public function invalidateTanksListS() : void
      {
         App.utils.asserter.assertNotNull(this.invalidateTanksList,"invalidateTanksList" + Errors.CANT_NULL);
         this.invalidateTanksList();
      }
      
      public function setFilterS(param1:Number, param2:String, param3:String, param4:String, param5:String) : void
      {
         App.utils.asserter.assertNotNull(this.setFilter,"setFilter" + Errors.CANT_NULL);
         this.setFilter(param1,param2,param3,param4,param5);
      }
      
      public function onShowRecruitWindowClickS(param1:Object, param2:Boolean) : void
      {
         App.utils.asserter.assertNotNull(this.onShowRecruitWindowClick,"onShowRecruitWindowClick" + Errors.CANT_NULL);
         this.onShowRecruitWindowClick(param1,param2);
      }
      
      public function actTankmanS(param1:String) : void
      {
         App.utils.asserter.assertNotNull(this.actTankman,"actTankman" + Errors.CANT_NULL);
         this.actTankman(param1);
      }
      
      public function buyBerthsS() : void
      {
         App.utils.asserter.assertNotNull(this.buyBerths,"buyBerths" + Errors.CANT_NULL);
         this.buyBerths();
      }
      
      public function closeBarracksS() : void
      {
         App.utils.asserter.assertNotNull(this.closeBarracks,"closeBarracks" + Errors.CANT_NULL);
         this.closeBarracks();
      }
      
      public function setTankmenFilterS() : void
      {
         App.utils.asserter.assertNotNull(this.setTankmenFilter,"setTankmenFilter" + Errors.CANT_NULL);
         this.setTankmenFilter();
      }
      
      public function openPersonalCaseS(param1:String, param2:uint) : void
      {
         App.utils.asserter.assertNotNull(this.openPersonalCase,"openPersonalCase" + Errors.CANT_NULL);
         this.openPersonalCase(param1,param2);
      }
      
      public function onCountersVisitedS(param1:Array) : void
      {
         App.utils.asserter.assertNotNull(this.onCountersVisited,"onCountersVisited" + Errors.CANT_NULL);
         this.onCountersVisited(param1);
      }
      
      public final function as_setTankmen(param1:Object) : void
      {
         var _loc2_:BarracksTankmenVO = this._barracksTankmenVO;
         this._barracksTankmenVO = new BarracksTankmenVO(param1);
         this.setTankmen(this._barracksTankmenVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      public final function as_updateTanksList(param1:Array) : void
      {
         var _loc2_:DataProvider = this._dataProvider;
         this._dataProvider = new DataProvider(param1);
         this.updateTanksList(this._dataProvider);
         if(_loc2_)
         {
            _loc2_.cleanUp();
         }
      }
      
      public final function as_setCountersData(param1:Array) : void
      {
         var _loc5_:CountersVo = null;
         var _loc2_:Vector.<CountersVo> = this._vectorCountersVo;
         this._vectorCountersVo = new Vector.<CountersVo>(0);
         var _loc3_:uint = param1.length;
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            this._vectorCountersVo[_loc4_] = new CountersVo(param1[_loc4_]);
            _loc4_++;
         }
         this.setCountersData(this._vectorCountersVo);
         if(_loc2_)
         {
            for each(_loc5_ in _loc2_)
            {
               _loc5_.dispose();
            }
            _loc2_.splice(0,_loc2_.length);
         }
      }
      
      protected function setTankmen(param1:BarracksTankmenVO) : void
      {
         var _loc2_:String = "as_setTankmen" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
      
      protected function updateTanksList(param1:DataProvider) : void
      {
         var _loc2_:String = "as_updateTanksList" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
      
      protected function setCountersData(param1:Vector.<CountersVo>) : void
      {
         var _loc2_:String = "as_setCountersData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
