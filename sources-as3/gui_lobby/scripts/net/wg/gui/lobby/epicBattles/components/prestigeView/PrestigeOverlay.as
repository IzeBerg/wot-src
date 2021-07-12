package net.wg.gui.lobby.epicBattles.components.prestigeView
{
   import flash.text.TextField;
   import flash.text.TextFormat;
   import net.wg.data.constants.generated.RANKEDBATTLES_ALIASES;
   import net.wg.gui.lobby.components.AwardItemRendererEx;
   import net.wg.gui.lobby.components.data.AwardItemRendererExVO;
   import net.wg.gui.lobby.epicBattles.data.EpicBattlesPrestigeViewVO;
   import net.wg.gui.lobby.eventProgression.components.metaLevel.EpicBattleMetaLevel;
   import net.wg.infrastructure.base.UIComponentEx;
   import scaleform.clik.constants.InvalidationType;
   
   public class PrestigeOverlay extends UIComponentEx
   {
      
      private static const PRESTIGE_TITLE_SIZE_SMALL:int = 24;
      
      private static const PRESTIGE_TITLE_SIZE_REGULAR:int = 29;
      
      private static const BREAKING_POINT_RESOLUTION:int = 768;
      
      private static const BIG_AWARD_ICON_SIZE:int = 80;
      
      private static const BIG_AWARD_ICON_OFFSET:int = 40;
      
      private static const BIG_AWARD_Y_OFFSET:int = 16;
       
      
      public var actionButtonsBar:ActionsButtonBar = null;
      
      public var prestigeInfoTF:TextField = null;
      
      public var prestigeLevelTF:TextField = null;
      
      public var prestigeMetaLevel:EpicBattleMetaLevel = null;
      
      public var exchangeTF:TextField = null;
      
      public var prestigeTitleTF:TextField = null;
      
      public var removeAbilitiesContainer:TextBlock = null;
      
      public var resetLevelContainer:TextBlock = null;
      
      private var _rewardContainers:Vector.<AwardItemRendererEx> = null;
      
      public function PrestigeOverlay()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         this.actionButtonsBar.dispose();
         this.actionButtonsBar = null;
         this.prestigeInfoTF = null;
         this.prestigeLevelTF = null;
         this.prestigeMetaLevel.dispose();
         this.prestigeMetaLevel = null;
         this.exchangeTF = null;
         this.prestigeTitleTF = null;
         this.removeAbilitiesContainer.dispose();
         this.removeAbilitiesContainer = null;
         this.resetLevelContainer.dispose();
         this.resetLevelContainer = null;
         if(this._rewardContainers)
         {
            _loc1_ = this._rewardContainers.length;
            _loc2_ = 0;
            while(_loc2_ < _loc1_)
            {
               this._rewardContainers[_loc2_].dispose();
               _loc2_++;
            }
            this._rewardContainers.splice(0,this._rewardContainers.length);
            this._rewardContainers = null;
         }
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.prestigeInfoTF.text = EPIC_BATTLE.EPICBATTLESPRESTIGEVIEW_PRESTIGEINFO;
         this.exchangeTF.text = EPIC_BATTLE.EPICBATTLESPRESTIGEVIEW_EXCHANGE;
         this.removeAbilitiesContainer.setDescription(EPIC_BATTLE.EPICBATTLESPRESTIGEVIEW_REMOVEABILITIES_DESC);
         this.resetLevelContainer.setDescription(EPIC_BATTLE.EPICBATTLESPRESTIGEVIEW_RESETLEVEL_DESC);
      }
      
      override protected function draw() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:AwardItemRendererEx = null;
         super.draw();
         if(this._rewardContainers && isInvalid(InvalidationType.SIZE))
         {
            _loc1_ = this.exchangeTF.x + (this.exchangeTF.width >> 1);
            _loc2_ = this._rewardContainers.length * BIG_AWARD_ICON_SIZE + (this._rewardContainers.length - 1) * BIG_AWARD_ICON_OFFSET;
            _loc3_ = _loc1_ - (_loc2_ >> 1);
            for each(_loc4_ in this._rewardContainers)
            {
               _loc4_.x = _loc3_;
               _loc4_.y = BIG_AWARD_Y_OFFSET;
               _loc3_ += BIG_AWARD_ICON_SIZE + BIG_AWARD_ICON_OFFSET;
            }
         }
      }
      
      public function setData(param1:EpicBattlesPrestigeViewVO) : void
      {
         var _loc2_:int = 0;
         var _loc3_:Function = null;
         var _loc4_:int = 0;
         var _loc5_:String = null;
         var _loc6_:AwardItemRendererEx = null;
         var _loc7_:AwardItemRendererExVO = null;
         this.prestigeTitleTF.text = param1.prestigeTitleText.toUpperCase();
         this.removeAbilitiesContainer.setTitle(param1.removeAbilitiesContainerTitleText.toUpperCase());
         this.resetLevelContainer.setTitle(param1.resetLevelContainerTitleText.toUpperCase());
         this.prestigeMetaLevel.setData(param1.metaLevelIconPrestige);
         this.prestigeLevelTF.text = param1.prestigeLevelText;
         if(param1.awards)
         {
            this._rewardContainers = new Vector.<AwardItemRendererEx>(0);
            _loc2_ = param1.awards.length;
            _loc3_ = App.utils.classFactory.getComponent;
            _loc4_ = 0;
            while(_loc4_ < _loc2_)
            {
               _loc5_ = RANKEDBATTLES_ALIASES.RANKED_AWARD_RENDERER_ALIAS;
               _loc6_ = _loc3_(_loc5_,AwardItemRendererEx);
               addChild(_loc6_);
               this._rewardContainers.push(_loc6_);
               _loc7_ = param1.awards[_loc4_];
               _loc6_.setData(_loc7_);
               _loc4_++;
            }
         }
         invalidateSize();
      }
      
      public function updateStage(param1:Number, param2:Number) : void
      {
         var _loc3_:TextFormat = this.prestigeTitleTF.getTextFormat();
         if(param2 <= BREAKING_POINT_RESOLUTION)
         {
            _loc3_.size = PRESTIGE_TITLE_SIZE_SMALL;
         }
         else
         {
            _loc3_.size = PRESTIGE_TITLE_SIZE_REGULAR;
         }
         this.prestigeTitleTF.setTextFormat(_loc3_);
      }
   }
}
