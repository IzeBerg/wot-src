package net.wg.gui.battle.epicBattle.views.stats.components
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   import net.wg.data.constants.InvalidationType;
   import net.wg.gui.battle.components.BattleUIComponent;
   import net.wg.gui.components.controls.UILoaderAlt;
   import org.idmedia.as3commons.util.StringUtils;
   
   public class EpicStatsHeader extends BattleUIComponent
   {
      
      private static const NORMAL_STATE:String = "normal";
      
      private static const SMALL_STATE:String = "small";
      
      private static const BATTLE_ICON_X:int = -68;
      
      private static const BATTLE_ICON_Y:int = 9;
      
      private static const BATTLE_ICON_SMALL_X:int = -32;
      
      private static const BATTLE_ICON_SMALL_Y:int = 17;
      
      private static const MAP_TF_X:int = -496;
      
      private static const MAP_TF_Y:int = 65;
      
      private static const BATTLE_TF_X:int = 65;
      
      private static const BATTLE_TF_Y:int = 50;
      
      private static const WIN_TF_Y:int = 75;
      
      private static const SMALL_SHIFT:int = 26;
      
      private static const SMALL_SHIFT_Y:int = 32;
       
      
      public var mapText:TextField = null;
      
      public var winText:TextField = null;
      
      public var battleText:TextField = null;
      
      public var battleIcon:UILoaderAlt = null;
      
      public var headerBg:MovieClip = null;
      
      private var _battleTypeStr:String;
      
      private var _winStr:String;
      
      private var _mapName:String = "";
      
      private var _battleTypeIconPath:String = "";
      
      private var _battleTypeIconPathSmall:String = "";
      
      private var _isSmallSize:Boolean = false;
      
      public function EpicStatsHeader()
      {
         super();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.DATA))
         {
            this.battleText.htmlText = this._battleTypeStr;
            if(StringUtils.isNotEmpty(this._winStr))
            {
               this.winText.htmlText = this._winStr;
            }
            this.mapText.htmlText = this._mapName;
            this.updateBattleIcon();
         }
      }
      
      override protected function onDispose() : void
      {
         this.mapText = null;
         this.battleText = null;
         this.winText = null;
         this.battleIcon.dispose();
         this.battleIcon = null;
         this.headerBg = null;
         super.onDispose();
      }
      
      public function setBattleTypeIconPath(param1:String) : void
      {
         if(param1 != this._battleTypeIconPath)
         {
            this._battleTypeIconPath = param1;
            invalidateData();
         }
      }
      
      public function setBattleTypeIconPathSmall(param1:String) : void
      {
         if(param1 != this._battleTypeIconPathSmall)
         {
            this._battleTypeIconPathSmall = param1;
            invalidateData();
         }
      }
      
      public function setBattleTypeName(param1:String) : void
      {
         if(param1 != this._battleTypeStr)
         {
            this._battleTypeStr = param1;
            invalidateData();
         }
      }
      
      public function updateMapName(param1:String) : void
      {
         if(param1 != this._mapName)
         {
            this._mapName = param1;
            invalidateData();
         }
      }
      
      public function updateWinText(param1:String) : void
      {
         if(param1 != this._winStr)
         {
            this._winStr = param1;
            invalidateData();
         }
      }
      
      public function updateSize(param1:Number, param2:Boolean) : void
      {
         this._isSmallSize = param2;
         this.headerBg.width = param1;
         this.headerBg.gotoAndStop(!!param2 ? SMALL_STATE : NORMAL_STATE);
         this.mapText.x = MAP_TF_X;
         this.mapText.y = MAP_TF_Y;
         this.battleText.x = BATTLE_TF_X;
         this.battleText.y = BATTLE_TF_Y;
         this.winText.y = WIN_TF_Y;
         if(param2)
         {
            this.mapText.x += SMALL_SHIFT;
            this.mapText.y -= SMALL_SHIFT;
            this.battleText.x -= SMALL_SHIFT;
            this.battleText.y -= SMALL_SHIFT_Y;
            this.winText.y -= SMALL_SHIFT_Y;
         }
         this.winText.x = this.battleText.x;
         this.updateBattleIcon();
      }
      
      private function updateBattleIcon() : void
      {
         if(this._isSmallSize)
         {
            this.battleIcon.source = this._battleTypeIconPathSmall;
            this.battleIcon.x = BATTLE_ICON_SMALL_X;
            this.battleIcon.y = BATTLE_ICON_SMALL_Y;
         }
         else
         {
            this.battleIcon.source = this._battleTypeIconPath;
            this.battleIcon.x = BATTLE_ICON_X;
            this.battleIcon.y = BATTLE_ICON_Y;
         }
      }
   }
}
