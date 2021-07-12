package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.lobby.rankedBattles19.data.RankedBattlesIntroBlockVO;
   import net.wg.gui.lobby.rankedBattles19.data.RankedBattlesPageHeaderVO;
   import net.wg.infrastructure.base.AbstractScreen;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class RankedBattlesIntroMeta extends AbstractScreen
   {
       
      
      public var onClose:Function;
      
      public var onAcceptClick:Function;
      
      public var onDetailedClick:Function;
      
      public var onPlayVideoClick:Function;
      
      private var _rankedBattlesPageHeaderVO:RankedBattlesPageHeaderVO;
      
      private var _vectorRankedBattlesIntroBlockVO:Vector.<RankedBattlesIntroBlockVO>;
      
      public function RankedBattlesIntroMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:RankedBattlesIntroBlockVO = null;
         if(this._rankedBattlesPageHeaderVO)
         {
            this._rankedBattlesPageHeaderVO.dispose();
            this._rankedBattlesPageHeaderVO = null;
         }
         if(this._vectorRankedBattlesIntroBlockVO)
         {
            for each(_loc1_ in this._vectorRankedBattlesIntroBlockVO)
            {
               _loc1_.dispose();
            }
            this._vectorRankedBattlesIntroBlockVO.splice(0,this._vectorRankedBattlesIntroBlockVO.length);
            this._vectorRankedBattlesIntroBlockVO = null;
         }
         super.onDispose();
      }
      
      public function onCloseS() : void
      {
         App.utils.asserter.assertNotNull(this.onClose,"onClose" + Errors.CANT_NULL);
         this.onClose();
      }
      
      public function onAcceptClickS() : void
      {
         App.utils.asserter.assertNotNull(this.onAcceptClick,"onAcceptClick" + Errors.CANT_NULL);
         this.onAcceptClick();
      }
      
      public function onDetailedClickS() : void
      {
         App.utils.asserter.assertNotNull(this.onDetailedClick,"onDetailedClick" + Errors.CANT_NULL);
         this.onDetailedClick();
      }
      
      public function onPlayVideoClickS() : void
      {
         App.utils.asserter.assertNotNull(this.onPlayVideoClick,"onPlayVideoClick" + Errors.CANT_NULL);
         this.onPlayVideoClick();
      }
      
      public final function as_setData(param1:Object, param2:Array) : void
      {
         var _loc7_:RankedBattlesIntroBlockVO = null;
         var _loc3_:RankedBattlesPageHeaderVO = this._rankedBattlesPageHeaderVO;
         this._rankedBattlesPageHeaderVO = new RankedBattlesPageHeaderVO(param1);
         var _loc4_:Vector.<RankedBattlesIntroBlockVO> = this._vectorRankedBattlesIntroBlockVO;
         this._vectorRankedBattlesIntroBlockVO = new Vector.<RankedBattlesIntroBlockVO>(0);
         var _loc5_:uint = param2.length;
         var _loc6_:int = 0;
         while(_loc6_ < _loc5_)
         {
            this._vectorRankedBattlesIntroBlockVO[_loc6_] = new RankedBattlesIntroBlockVO(param2[_loc6_]);
            _loc6_++;
         }
         this.setData(this._rankedBattlesPageHeaderVO,this._vectorRankedBattlesIntroBlockVO);
         if(_loc3_)
         {
            _loc3_.dispose();
         }
         if(_loc4_)
         {
            for each(_loc7_ in _loc4_)
            {
               _loc7_.dispose();
            }
            _loc4_.splice(0,_loc4_.length);
         }
      }
      
      protected function setData(param1:RankedBattlesPageHeaderVO, param2:Vector.<RankedBattlesIntroBlockVO>) : void
      {
         var _loc3_:String = "as_setData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc3_);
         throw new AbstractException(_loc3_);
      }
   }
}
