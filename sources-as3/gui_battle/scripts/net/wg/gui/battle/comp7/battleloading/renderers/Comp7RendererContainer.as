package net.wg.gui.battle.comp7.battleloading.renderers
{
   import flash.text.TextField;
   import net.wg.gui.battle.components.BattleAtlasSprite;
   import net.wg.gui.battle.components.PrestigeLevel;
   import net.wg.gui.battle.random.battleloading.renderers.RandomRendererContainer;
   import net.wg.gui.components.controls.BadgeComponent;
   import net.wg.gui.components.icons.PlayerActionMarker;
   
   public class Comp7RendererContainer extends RandomRendererContainer
   {
       
      
      public var rankIconAlly0:BattleAtlasSprite;
      
      public var rankIconAlly1:BattleAtlasSprite;
      
      public var rankIconAlly2:BattleAtlasSprite;
      
      public var rankIconAlly3:BattleAtlasSprite;
      
      public var rankIconAlly4:BattleAtlasSprite;
      
      public var rankIconAlly5:BattleAtlasSprite;
      
      public var rankIconAlly6:BattleAtlasSprite;
      
      public var rankIconEnemy0:BattleAtlasSprite;
      
      public var rankIconEnemy1:BattleAtlasSprite;
      
      public var rankIconEnemy2:BattleAtlasSprite;
      
      public var rankIconEnemy3:BattleAtlasSprite;
      
      public var rankIconEnemy4:BattleAtlasSprite;
      
      public var rankIconEnemy5:BattleAtlasSprite;
      
      public var rankIconEnemy6:BattleAtlasSprite;
      
      public var rankIconsAlly:Vector.<BattleAtlasSprite>;
      
      public var rankIconsEnemy:Vector.<BattleAtlasSprite>;
      
      public function Comp7RendererContainer()
      {
         super();
         this.rankIconsAlly = new <BattleAtlasSprite>[this.rankIconAlly0,this.rankIconAlly1,this.rankIconAlly2,this.rankIconAlly3,this.rankIconAlly4,this.rankIconAlly5,this.rankIconAlly6];
         this.rankIconsEnemy = new <BattleAtlasSprite>[this.rankIconEnemy0,this.rankIconEnemy1,this.rankIconEnemy2,this.rankIconEnemy3,this.rankIconEnemy4,this.rankIconEnemy5,this.rankIconEnemy6];
      }
      
      override protected function onDispose() : void
      {
         this.rankIconsAlly.length = 0;
         this.rankIconsAlly = null;
         this.rankIconsEnemy.length = 0;
         this.rankIconsEnemy = null;
         this.rankIconAlly0 = null;
         this.rankIconAlly1 = null;
         this.rankIconAlly2 = null;
         this.rankIconAlly3 = null;
         this.rankIconAlly4 = null;
         this.rankIconAlly5 = null;
         this.rankIconAlly6 = null;
         this.rankIconEnemy0 = null;
         this.rankIconEnemy1 = null;
         this.rankIconEnemy2 = null;
         this.rankIconEnemy3 = null;
         this.rankIconEnemy4 = null;
         this.rankIconEnemy5 = null;
         this.rankIconEnemy6 = null;
         super.onDispose();
      }
      
      override protected function getIcoTestersAlly() : Vector.<BattleAtlasSprite>
      {
         return new <BattleAtlasSprite>[icoTesterAlly0,icoTesterAlly1,icoTesterAlly2,icoTesterAlly3,icoTesterAlly4,icoTesterAlly5,icoTesterAlly6];
      }
      
      override protected function getBackTestersAlly() : Vector.<BattleAtlasSprite>
      {
         return new <BattleAtlasSprite>[testerBack_c1r1,testerBack_c1r2,testerBack_c1r3,testerBack_c1r4,testerBack_c1r5,testerBack_c1r6,testerBack_c1r7];
      }
      
      override protected function getTextFieldsAlly() : Vector.<TextField>
      {
         return new <TextField>[textFieldAlly0,textFieldAlly1,textFieldAlly2,textFieldAlly3,textFieldAlly4,textFieldAlly5,textFieldAlly6];
      }
      
      override protected function getVehicleFieldsAlly() : Vector.<TextField>
      {
         return null;
      }
      
      override protected function getPlayerActionMarkersAlly() : Vector.<PlayerActionMarker>
      {
         return new <PlayerActionMarker>[playerActionMarkerAlly0,playerActionMarkerAlly1,playerActionMarkerAlly2,playerActionMarkerAlly3,playerActionMarkerAlly4,playerActionMarkerAlly5,playerActionMarkerAlly6];
      }
      
      override protected function getVehicleTypeIconsAlly() : Vector.<BattleAtlasSprite>
      {
         return null;
      }
      
      override protected function getVehicleLevelIconsAlly() : Vector.<BattleAtlasSprite>
      {
         return null;
      }
      
      override protected function getVehicleIconsAlly() : Vector.<BattleAtlasSprite>
      {
         return null;
      }
      
      override protected function getPrestigeLevelsAlly() : Vector.<PrestigeLevel>
      {
         return null;
      }
      
      override protected function getIcoIGRsAlly() : Vector.<BattleAtlasSprite>
      {
         return null;
      }
      
      override protected function getBadgesAlly() : Vector.<BadgeComponent>
      {
         return new <BadgeComponent>[badgeAlly0,badgeAlly1,badgeAlly2,badgeAlly3,badgeAlly4,badgeAlly5,badgeAlly6];
      }
      
      override protected function getSelfBgs() : Vector.<BattleAtlasSprite>
      {
         return new <BattleAtlasSprite>[selfBgAlly0,selfBgAlly1,selfBgAlly2,selfBgAlly3,selfBgAlly4,selfBgAlly5,selfBgAlly6];
      }
      
      override protected function getIcoTestersEnemy() : Vector.<BattleAtlasSprite>
      {
         return new <BattleAtlasSprite>[icoTesterEnemy0,icoTesterEnemy1,icoTesterEnemy2,icoTesterEnemy3,icoTesterEnemy4,icoTesterEnemy5,icoTesterEnemy6];
      }
      
      override protected function getBackTestersEnemy() : Vector.<BattleAtlasSprite>
      {
         return new <BattleAtlasSprite>[testerBack_c2r1,testerBack_c2r2,testerBack_c2r3,testerBack_c2r4,testerBack_c2r5,testerBack_c2r6,testerBack_c2r7];
      }
      
      override protected function getTextFieldsEnemy() : Vector.<TextField>
      {
         return new <TextField>[textFieldEnemy0,textFieldEnemy1,textFieldEnemy2,textFieldEnemy3,textFieldEnemy4,textFieldEnemy5,textFieldEnemy6];
      }
      
      override protected function getVehicleFieldsEnemy() : Vector.<TextField>
      {
         return null;
      }
      
      override protected function getPlayerActionMarkersEnemy() : Vector.<PlayerActionMarker>
      {
         return new <PlayerActionMarker>[playerActionMarkerEnemy0,playerActionMarkerEnemy1,playerActionMarkerEnemy2,playerActionMarkerEnemy3,playerActionMarkerEnemy4,playerActionMarkerEnemy5,playerActionMarkerEnemy6];
      }
      
      override protected function getVehicleTypeIconsEnemy() : Vector.<BattleAtlasSprite>
      {
         return null;
      }
      
      override protected function getVehicleLevelIconsEnemy() : Vector.<BattleAtlasSprite>
      {
         return null;
      }
      
      override protected function getVehicleIconsEnemy() : Vector.<BattleAtlasSprite>
      {
         return null;
      }
      
      override protected function getPrestigeLevelsEnemy() : Vector.<PrestigeLevel>
      {
         return null;
      }
      
      override protected function getIcoIGRsEnemy() : Vector.<BattleAtlasSprite>
      {
         return null;
      }
      
      override protected function getBadgesEnemy() : Vector.<BadgeComponent>
      {
         return new <BadgeComponent>[badgeEnemy0,badgeEnemy1,badgeEnemy2,badgeEnemy3,badgeEnemy4,badgeEnemy5,badgeEnemy6];
      }
      
      override protected function getSquadsAlly() : Vector.<BattleAtlasSprite>
      {
         return new <BattleAtlasSprite>[squadAlly0,squadAlly1,squadAlly2,squadAlly3,squadAlly4,squadAlly5,squadAlly6];
      }
      
      override protected function getSquadsEnemy() : Vector.<BattleAtlasSprite>
      {
         return new <BattleAtlasSprite>[squadEnemy0,squadEnemy1,squadEnemy2,squadEnemy3,squadEnemy4,squadEnemy5,squadEnemy6];
      }
   }
}
