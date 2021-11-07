package net.wg.gui.battle.ranked.battleloading.renderers
{
   import net.wg.gui.battle.battleloading.renderers.BaseRendererContainer;
   import net.wg.gui.battle.components.BattleAtlasSprite;
   
   public class RankedRendererContainer extends BaseRendererContainer
   {
       
      
      public var rankIconAlly0:BattleAtlasSprite;
      
      public var rankIconAlly1:BattleAtlasSprite;
      
      public var rankIconAlly2:BattleAtlasSprite;
      
      public var rankIconAlly3:BattleAtlasSprite;
      
      public var rankIconAlly4:BattleAtlasSprite;
      
      public var rankIconAlly5:BattleAtlasSprite;
      
      public var rankIconAlly6:BattleAtlasSprite;
      
      public var rankIconAlly7:BattleAtlasSprite;
      
      public var rankIconAlly8:BattleAtlasSprite;
      
      public var rankIconAlly9:BattleAtlasSprite;
      
      public var rankIconAlly10:BattleAtlasSprite;
      
      public var rankIconAlly11:BattleAtlasSprite;
      
      public var rankIconAlly12:BattleAtlasSprite;
      
      public var rankIconAlly13:BattleAtlasSprite;
      
      public var rankIconAlly14:BattleAtlasSprite;
      
      public var rankIconEnemy0:BattleAtlasSprite;
      
      public var rankIconEnemy1:BattleAtlasSprite;
      
      public var rankIconEnemy2:BattleAtlasSprite;
      
      public var rankIconEnemy3:BattleAtlasSprite;
      
      public var rankIconEnemy4:BattleAtlasSprite;
      
      public var rankIconEnemy5:BattleAtlasSprite;
      
      public var rankIconEnemy6:BattleAtlasSprite;
      
      public var rankIconEnemy7:BattleAtlasSprite;
      
      public var rankIconEnemy8:BattleAtlasSprite;
      
      public var rankIconEnemy9:BattleAtlasSprite;
      
      public var rankIconEnemy10:BattleAtlasSprite;
      
      public var rankIconEnemy11:BattleAtlasSprite;
      
      public var rankIconEnemy12:BattleAtlasSprite;
      
      public var rankIconEnemy13:BattleAtlasSprite;
      
      public var rankIconEnemy14:BattleAtlasSprite;
      
      public var rankIconsAlly:Vector.<BattleAtlasSprite>;
      
      public var rankIconsEnemy:Vector.<BattleAtlasSprite>;
      
      public function RankedRendererContainer()
      {
         super();
         this.rankIconsAlly = new <BattleAtlasSprite>[this.rankIconAlly0,this.rankIconAlly1,this.rankIconAlly2,this.rankIconAlly3,this.rankIconAlly4,this.rankIconAlly5,this.rankIconAlly6,this.rankIconAlly7,this.rankIconAlly8,this.rankIconAlly9,this.rankIconAlly10,this.rankIconAlly11,this.rankIconAlly12,this.rankIconAlly13,this.rankIconAlly14];
         this.rankIconsEnemy = new <BattleAtlasSprite>[this.rankIconEnemy0,this.rankIconEnemy1,this.rankIconEnemy2,this.rankIconEnemy3,this.rankIconEnemy4,this.rankIconEnemy5,this.rankIconEnemy6,this.rankIconEnemy7,this.rankIconEnemy8,this.rankIconEnemy9,this.rankIconEnemy10,this.rankIconEnemy11,this.rankIconEnemy12,this.rankIconEnemy13,this.rankIconEnemy14];
      }
      
      override public function dispose() : void
      {
         this.rankIconsAlly.length = 0;
         this.rankIconsEnemy.length = 0;
         this.rankIconsAlly = null;
         this.rankIconsEnemy = null;
         this.rankIconAlly0 = null;
         this.rankIconAlly1 = null;
         this.rankIconAlly2 = null;
         this.rankIconAlly3 = null;
         this.rankIconAlly4 = null;
         this.rankIconAlly5 = null;
         this.rankIconAlly6 = null;
         this.rankIconAlly7 = null;
         this.rankIconAlly8 = null;
         this.rankIconAlly9 = null;
         this.rankIconAlly10 = null;
         this.rankIconAlly11 = null;
         this.rankIconAlly12 = null;
         this.rankIconAlly13 = null;
         this.rankIconAlly14 = null;
         this.rankIconEnemy0 = null;
         this.rankIconEnemy1 = null;
         this.rankIconEnemy2 = null;
         this.rankIconEnemy3 = null;
         this.rankIconEnemy4 = null;
         this.rankIconEnemy5 = null;
         this.rankIconEnemy6 = null;
         this.rankIconEnemy7 = null;
         this.rankIconEnemy8 = null;
         this.rankIconEnemy9 = null;
         this.rankIconEnemy10 = null;
         this.rankIconEnemy11 = null;
         this.rankIconEnemy12 = null;
         this.rankIconEnemy13 = null;
         this.rankIconEnemy14 = null;
         super.dispose();
      }
   }
}
