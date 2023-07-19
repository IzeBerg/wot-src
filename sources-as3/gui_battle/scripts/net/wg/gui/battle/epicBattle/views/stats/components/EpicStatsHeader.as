package net.wg.gui.battle.epicBattle.views.stats.components
{
   import flash.display.Sprite;
   import flash.text.TextField;
   import net.wg.data.constants.InvalidationType;
   import net.wg.gui.battle.components.BattleUIComponent;
   import net.wg.gui.components.controls.UILoaderAlt;
   import org.idmedia.as3commons.util.StringUtils;
   
   public class EpicStatsHeader extends BattleUIComponent
   {
       
      
      public var mapText:TextField = null;
      
      public var winText:TextField = null;
      
      public var battleText:TextField = null;
      
      public var battleIcon:UILoaderAlt = null;
      
      public var modalBgSpr:Sprite = null;
      
      private var _battleTypeStr:String;
      
      private var _winStr:String;
      
      private var _mapName:String = "";
      
      private var _battleTypeIconPath:String = "";
      
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
            this.battleIcon.visible = true;
            this.battleIcon.source = this._battleTypeIconPath;
         }
      }
      
      override protected function onDispose() : void
      {
         this.mapText = null;
         this.battleText = null;
         this.winText = null;
         this.battleIcon.dispose();
         this.battleIcon = null;
         this.modalBgSpr = null;
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
   }
}
