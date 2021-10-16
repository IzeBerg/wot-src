package net.wg.gui.battle.random.battleloading.renderers
{
   import net.wg.gui.battle.battleloading.renderers.BaseRendererContainer;
   import net.wg.gui.battle.components.BattleAtlasSprite;
   
   public class RandomRendererContainer extends BaseRendererContainer
   {
       
      
      public var squadAlly0:BattleAtlasSprite;
      
      public var squadAlly1:BattleAtlasSprite;
      
      public var squadAlly2:BattleAtlasSprite;
      
      public var squadAlly3:BattleAtlasSprite;
      
      public var squadAlly4:BattleAtlasSprite;
      
      public var squadAlly5:BattleAtlasSprite;
      
      public var squadAlly6:BattleAtlasSprite;
      
      public var squadAlly7:BattleAtlasSprite;
      
      public var squadAlly8:BattleAtlasSprite;
      
      public var squadAlly9:BattleAtlasSprite;
      
      public var squadAlly10:BattleAtlasSprite;
      
      public var squadAlly11:BattleAtlasSprite;
      
      public var squadAlly12:BattleAtlasSprite;
      
      public var squadAlly13:BattleAtlasSprite;
      
      public var squadAlly14:BattleAtlasSprite;
      
      public var squadEnemy0:BattleAtlasSprite;
      
      public var squadEnemy1:BattleAtlasSprite;
      
      public var squadEnemy2:BattleAtlasSprite;
      
      public var squadEnemy3:BattleAtlasSprite;
      
      public var squadEnemy4:BattleAtlasSprite;
      
      public var squadEnemy5:BattleAtlasSprite;
      
      public var squadEnemy6:BattleAtlasSprite;
      
      public var squadEnemy7:BattleAtlasSprite;
      
      public var squadEnemy8:BattleAtlasSprite;
      
      public var squadEnemy9:BattleAtlasSprite;
      
      public var squadEnemy10:BattleAtlasSprite;
      
      public var squadEnemy11:BattleAtlasSprite;
      
      public var squadEnemy12:BattleAtlasSprite;
      
      public var squadEnemy13:BattleAtlasSprite;
      
      public var squadEnemy14:BattleAtlasSprite;
      
      public var squadsAlly:Vector.<BattleAtlasSprite>;
      
      public var squadsEnemy:Vector.<BattleAtlasSprite>;
      
      public function RandomRendererContainer()
      {
         super();
         this.squadsAlly = new <BattleAtlasSprite>[this.squadAlly0,this.squadAlly1,this.squadAlly2,this.squadAlly3,this.squadAlly4,this.squadAlly5,this.squadAlly6,this.squadAlly7,this.squadAlly8,this.squadAlly9,this.squadAlly10,this.squadAlly11,this.squadAlly12,this.squadAlly13,this.squadAlly14];
         this.squadsEnemy = new <BattleAtlasSprite>[this.squadEnemy0,this.squadEnemy1,this.squadEnemy2,this.squadEnemy3,this.squadEnemy4,this.squadEnemy5,this.squadEnemy6,this.squadEnemy7,this.squadEnemy8,this.squadEnemy9,this.squadEnemy10,this.squadEnemy11,this.squadEnemy12,this.squadEnemy13,this.squadEnemy14];
      }
      
      override public function dispose() : void
      {
         this.squadsAlly.length = 0;
         this.squadsAlly = null;
         this.squadsEnemy.length = 0;
         this.squadsEnemy = null;
         this.squadAlly0 = null;
         this.squadAlly1 = null;
         this.squadAlly2 = null;
         this.squadAlly3 = null;
         this.squadAlly4 = null;
         this.squadAlly5 = null;
         this.squadAlly6 = null;
         this.squadAlly7 = null;
         this.squadAlly8 = null;
         this.squadAlly9 = null;
         this.squadAlly10 = null;
         this.squadAlly11 = null;
         this.squadAlly12 = null;
         this.squadAlly13 = null;
         this.squadAlly14 = null;
         this.squadEnemy0 = null;
         this.squadEnemy1 = null;
         this.squadEnemy2 = null;
         this.squadEnemy3 = null;
         this.squadEnemy4 = null;
         this.squadEnemy5 = null;
         this.squadEnemy6 = null;
         this.squadEnemy7 = null;
         this.squadEnemy8 = null;
         this.squadEnemy9 = null;
         this.squadEnemy10 = null;
         this.squadEnemy11 = null;
         this.squadEnemy12 = null;
         this.squadEnemy13 = null;
         this.squadEnemy14 = null;
         super.dispose();
      }
   }
}
