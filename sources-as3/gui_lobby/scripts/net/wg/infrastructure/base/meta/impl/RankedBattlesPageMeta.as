package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.VO.CountersVo;
   import net.wg.data.constants.Errors;
   import net.wg.gui.lobby.rankedBattles19.data.RankedBattlesPageHeaderVO;
   import net.wg.gui.lobby.rankedBattles19.data.RankedBattlesPageVO;
   import net.wg.infrastructure.base.AbstractScreen;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class RankedBattlesPageMeta extends AbstractScreen
   {
       
      
      public var onClose:Function;
      
      public var onPageChanged:Function;
      
      private var _rankedBattlesPageVO:RankedBattlesPageVO;
      
      private var _rankedBattlesPageHeaderVO:RankedBattlesPageHeaderVO;
      
      private var _vectorCountersVo:Vector.<CountersVo>;
      
      public function RankedBattlesPageMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:CountersVo = null;
         if(this._rankedBattlesPageVO)
         {
            this._rankedBattlesPageVO.dispose();
            this._rankedBattlesPageVO = null;
         }
         if(this._rankedBattlesPageHeaderVO)
         {
            this._rankedBattlesPageHeaderVO.dispose();
            this._rankedBattlesPageHeaderVO = null;
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
      
      public function onCloseS() : void
      {
         App.utils.asserter.assertNotNull(this.onClose,"onClose" + Errors.CANT_NULL);
         this.onClose();
      }
      
      public function onPageChangedS(param1:String) : void
      {
         App.utils.asserter.assertNotNull(this.onPageChanged,"onPageChanged" + Errors.CANT_NULL);
         this.onPageChanged(param1);
      }
      
      public final function as_setData(param1:Object) : void
      {
         var _loc2_:RankedBattlesPageVO = this._rankedBattlesPageVO;
         this._rankedBattlesPageVO = new RankedBattlesPageVO(param1);
         this.setData(this._rankedBattlesPageVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      public final function as_setHeaderData(param1:Object) : void
      {
         var _loc2_:RankedBattlesPageHeaderVO = this._rankedBattlesPageHeaderVO;
         this._rankedBattlesPageHeaderVO = new RankedBattlesPageHeaderVO(param1);
         this.setHeaderData(this._rankedBattlesPageHeaderVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      public final function as_setCounters(param1:Array) : void
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
         this.setCounters(this._vectorCountersVo);
         if(_loc2_)
         {
            for each(_loc5_ in _loc2_)
            {
               _loc5_.dispose();
            }
            _loc2_.splice(0,_loc2_.length);
         }
      }
      
      protected function setData(param1:RankedBattlesPageVO) : void
      {
         var _loc2_:String = "as_setData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
      
      protected function setHeaderData(param1:RankedBattlesPageHeaderVO) : void
      {
         var _loc2_:String = "as_setHeaderData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
      
      protected function setCounters(param1:Vector.<CountersVo>) : void
      {
         var _loc2_:String = "as_setCounters" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
