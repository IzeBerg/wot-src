package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.components.tooltips.inblocks.data.BlockDataItemVO;
   import net.wg.gui.lobby.epicBattles.data.EpicBattlesSkillViewVO;
   import net.wg.gui.lobby.rankedBattles19.view.base.HangarRankedScreen;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class EpicBattlesSkillViewMeta extends HangarRankedScreen
   {
       
      
      public var onEscapePress:Function;
      
      public var onBackBtnClick:Function;
      
      public var onCloseBtnClick:Function;
      
      public var onSelectSkillBtnClick:Function;
      
      public var onSkillUpgrade:Function;
      
      public var onSkillOverLevel:Function;
      
      private var _epicBattlesSkillViewVO:EpicBattlesSkillViewVO;
      
      private var _blockDataItemVO:BlockDataItemVO;
      
      public function EpicBattlesSkillViewMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         if(this._epicBattlesSkillViewVO)
         {
            this._epicBattlesSkillViewVO.dispose();
            this._epicBattlesSkillViewVO = null;
         }
         if(this._blockDataItemVO)
         {
            this._blockDataItemVO.dispose();
            this._blockDataItemVO = null;
         }
         super.onDispose();
      }
      
      public function onEscapePressS() : void
      {
         App.utils.asserter.assertNotNull(this.onEscapePress,"onEscapePress" + Errors.CANT_NULL);
         this.onEscapePress();
      }
      
      public function onBackBtnClickS() : void
      {
         App.utils.asserter.assertNotNull(this.onBackBtnClick,"onBackBtnClick" + Errors.CANT_NULL);
         this.onBackBtnClick();
      }
      
      public function onCloseBtnClickS() : void
      {
         App.utils.asserter.assertNotNull(this.onCloseBtnClick,"onCloseBtnClick" + Errors.CANT_NULL);
         this.onCloseBtnClick();
      }
      
      public function onSelectSkillBtnClickS(param1:int) : void
      {
         App.utils.asserter.assertNotNull(this.onSelectSkillBtnClick,"onSelectSkillBtnClick" + Errors.CANT_NULL);
         this.onSelectSkillBtnClick(param1);
      }
      
      public function onSkillUpgradeS(param1:int) : void
      {
         App.utils.asserter.assertNotNull(this.onSkillUpgrade,"onSkillUpgrade" + Errors.CANT_NULL);
         this.onSkillUpgrade(param1);
      }
      
      public function onSkillOverLevelS(param1:int, param2:int) : void
      {
         App.utils.asserter.assertNotNull(this.onSkillOverLevel,"onSkillOverLevel" + Errors.CANT_NULL);
         this.onSkillOverLevel(param1,param2);
      }
      
      public final function as_setData(param1:Object) : void
      {
         var _loc2_:EpicBattlesSkillViewVO = this._epicBattlesSkillViewVO;
         this._epicBattlesSkillViewVO = new EpicBattlesSkillViewVO(param1);
         this.setData(this._epicBattlesSkillViewVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      public final function as_setSkillDataBlock(param1:Object) : void
      {
         var _loc2_:BlockDataItemVO = this._blockDataItemVO;
         this._blockDataItemVO = new BlockDataItemVO(param1);
         this.setSkillDataBlock(this._blockDataItemVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      protected function setData(param1:EpicBattlesSkillViewVO) : void
      {
         var _loc2_:String = "as_setData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
      
      protected function setSkillDataBlock(param1:BlockDataItemVO) : void
      {
         var _loc2_:String = "as_setSkillDataBlock" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
