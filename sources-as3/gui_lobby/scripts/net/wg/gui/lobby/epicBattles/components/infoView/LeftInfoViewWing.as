package net.wg.gui.lobby.epicBattles.components.infoView
{
   import flash.display.MovieClip;
   import net.wg.data.constants.generated.RANKEDBATTLES_ALIASES;
   import net.wg.gui.lobby.components.AwardItemRendererEx;
   import net.wg.gui.lobby.components.data.AwardItemRendererExVO;
   import net.wg.gui.lobby.epicBattles.data.EpicBattlesInfoMetaProgressVO;
   import net.wg.infrastructure.base.UIComponentEx;
   import scaleform.clik.constants.InvalidationType;
   
   public class LeftInfoViewWing extends UIComponentEx
   {
      
      private static const SMALL_AWARD_ICON_SIZE:int = 48;
      
      private static const SMALL_AWARD_ICON_OFFESET:int = 12;
      
      private static const SMALL_SCALE:Number = 0.8;
      
      private static const REGULAR_SCALE:Number = 1;
      
      private static const SMALL_X_OFFSET:int = -210;
      
      private static const REGULAR_X_OFFSET:int = -240;
      
      private static const PRESTIGE_Y_AWARDS_OFFSET:int = -30;
      
      private static const META_LEVEL_PROGRESS_Y_AWARDS_OFFSET:int = 33;
       
      
      public var metaProgressPanel:MetaProgressPanel = null;
      
      public var prestigeAllowedPanel:PrestigeAllowedPanel = null;
      
      public var endGamePanel:EndGamePanel = null;
      
      public var prestigeBackground:MovieClip = null;
      
      public var normalBackground:MovieClip = null;
      
      private var _isSmallMode:Boolean = false;
      
      private var _canPrestige:Boolean = false;
      
      private var _awards:Vector.<AwardItemRendererEx> = null;
      
      public function LeftInfoViewWing()
      {
         super();
      }
      
      override protected function draw() : void
      {
         var _loc1_:UIComponentEx = null;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:AwardItemRendererEx = null;
         super.draw();
         if(isInvalid(InvalidationType.SIZE))
         {
            if(this._isSmallMode)
            {
               this.prestigeBackground.scaleX = this.prestigeBackground.scaleY = SMALL_SCALE;
               this.normalBackground.scaleX = this.normalBackground.scaleY = SMALL_SCALE;
               this.prestigeAllowedPanel.x = SMALL_X_OFFSET;
               this.metaProgressPanel.x = SMALL_X_OFFSET;
               this.endGamePanel.x = SMALL_X_OFFSET;
            }
            else
            {
               this.prestigeBackground.scaleX = this.prestigeBackground.scaleY = REGULAR_SCALE;
               this.normalBackground.scaleX = this.normalBackground.scaleY = REGULAR_SCALE;
               this.prestigeAllowedPanel.x = REGULAR_X_OFFSET;
               this.metaProgressPanel.x = REGULAR_X_OFFSET;
               this.endGamePanel.x = REGULAR_X_OFFSET;
            }
            if(this._awards)
            {
               _loc1_ = !!this._canPrestige ? this.prestigeAllowedPanel : this.metaProgressPanel;
               _loc2_ = _loc1_.x - (_loc1_.width >> 1);
               _loc3_ = this._awards.length * SMALL_AWARD_ICON_SIZE + (this._awards.length - 1) * SMALL_AWARD_ICON_OFFESET;
               _loc4_ = _loc2_ - (_loc3_ >> 1);
               for each(_loc5_ in this._awards)
               {
                  _loc5_.x = _loc4_;
                  _loc5_.y = !!this._canPrestige ? Number(PRESTIGE_Y_AWARDS_OFFSET) : Number(META_LEVEL_PROGRESS_Y_AWARDS_OFFSET);
                  _loc4_ += SMALL_AWARD_ICON_SIZE + SMALL_AWARD_ICON_OFFESET;
               }
            }
         }
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         this.metaProgressPanel.dispose();
         this.metaProgressPanel = null;
         this.prestigeAllowedPanel.dispose();
         this.prestigeAllowedPanel = null;
         this.endGamePanel.dispose();
         this.endGamePanel = null;
         this.prestigeBackground = null;
         this.normalBackground = null;
         if(this._awards)
         {
            _loc1_ = this._awards.length;
            _loc2_ = 0;
            while(_loc2_ < _loc1_)
            {
               this._awards[_loc2_].dispose();
               _loc2_++;
            }
            this._awards.splice(0,this._awards.length);
            this._awards = null;
         }
         super.onDispose();
      }
      
      public function setData(param1:EpicBattlesInfoMetaProgressVO) : void
      {
         var _loc2_:int = 0;
         var _loc3_:Function = null;
         var _loc4_:int = 0;
         var _loc5_:String = null;
         var _loc6_:AwardItemRendererEx = null;
         var _loc7_:AwardItemRendererExVO = null;
         if(param1.isEndGameState)
         {
            this.metaProgressPanel.visible = false;
            this.prestigeAllowedPanel.visible = this.prestigeBackground.visible = false;
            this.endGamePanel.visible = this.normalBackground.visible = true;
            this.endGamePanel.setData(param1);
         }
         else if(param1.canPrestige)
         {
            this.metaProgressPanel.visible = this.normalBackground.visible = false;
            this.prestigeAllowedPanel.visible = this.prestigeBackground.visible = true;
            this.endGamePanel.visible = false;
            this.prestigeAllowedPanel.setData(param1);
         }
         else
         {
            this.metaProgressPanel.visible = this.normalBackground.visible = true;
            this.prestigeAllowedPanel.visible = this.prestigeBackground.visible = false;
            this.endGamePanel.visible = false;
            this.metaProgressPanel.setData(param1);
         }
         this._canPrestige = param1.canPrestige;
         if(param1.awards)
         {
            this._awards = new Vector.<AwardItemRendererEx>(0);
            _loc2_ = param1.awards.length;
            _loc3_ = App.utils.classFactory.getComponent;
            _loc4_ = 0;
            while(_loc4_ < _loc2_)
            {
               _loc5_ = RANKEDBATTLES_ALIASES.RANKED_AWARD_RENDERER_ALIAS;
               _loc6_ = _loc3_(_loc5_,AwardItemRendererEx);
               addChild(_loc6_);
               this._awards.push(_loc6_);
               _loc7_ = param1.awards[_loc4_];
               _loc6_.setData(_loc7_);
               _loc4_++;
            }
         }
         invalidateSize();
      }
      
      public function set isSmallMode(param1:Boolean) : void
      {
         this._isSmallMode = param1;
         invalidateSize();
      }
   }
}
