package net.wg.white_tiger.gui.battle.views.wtFullStats
{
   import flash.display.Sprite;
   import net.wg.data.constants.generated.BATTLEATLAS;
   import net.wg.gui.battle.random.views.stats.components.fullStats.FullStatsTable;
   import net.wg.white_tiger.gui.battle.views.shared.HunterResurrectTimer;
   
   public class FullStatsTable extends net.wg.gui.battle.random.views.stats.components.fullStats.FullStatsTable
   {
       
      
      public var resurrectTimer_c1r1:HunterResurrectTimer = null;
      
      public var resurrectTimer_c1r2:HunterResurrectTimer = null;
      
      public var resurrectTimer_c1r3:HunterResurrectTimer = null;
      
      public var resurrectTimer_c1r4:HunterResurrectTimer = null;
      
      public var resurrectTimer_c1r5:HunterResurrectTimer = null;
      
      public var resurrectTimer_c1r6:HunterResurrectTimer = null;
      
      public var resurrectTimer_c1r7:HunterResurrectTimer = null;
      
      public var resurrectTimer_c1r8:HunterResurrectTimer = null;
      
      public var resurrectTimer_c1r9:HunterResurrectTimer = null;
      
      public var resurrectTimer_c1r10:HunterResurrectTimer = null;
      
      public var resurrectTimer_c1r11:HunterResurrectTimer = null;
      
      public var resurrectTimer_c1r12:HunterResurrectTimer = null;
      
      public var resurrectTimer_c1r13:HunterResurrectTimer = null;
      
      public var resurrectTimer_c1r14:HunterResurrectTimer = null;
      
      public var resurrectTimer_c1r15:HunterResurrectTimer = null;
      
      public var resurrectTimer_c2r1:HunterResurrectTimer = null;
      
      public var resurrectTimer_c2r2:HunterResurrectTimer = null;
      
      public var resurrectTimer_c2r3:HunterResurrectTimer = null;
      
      public var resurrectTimer_c2r4:HunterResurrectTimer = null;
      
      public var resurrectTimer_c2r5:HunterResurrectTimer = null;
      
      public var resurrectTimer_c2r6:HunterResurrectTimer = null;
      
      public var resurrectTimer_c2r7:HunterResurrectTimer = null;
      
      public var resurrectTimer_c2r8:HunterResurrectTimer = null;
      
      public var resurrectTimer_c2r9:HunterResurrectTimer = null;
      
      public var resurrectTimer_c2r10:HunterResurrectTimer = null;
      
      public var resurrectTimer_c2r11:HunterResurrectTimer = null;
      
      public var resurrectTimer_c2r12:HunterResurrectTimer = null;
      
      public var resurrectTimer_c2r13:HunterResurrectTimer = null;
      
      public var resurrectTimer_c2r14:HunterResurrectTimer = null;
      
      public var resurrectTimer_c2r15:HunterResurrectTimer = null;
      
      public var carrierBg_c1r1:Sprite = null;
      
      public var carrierBg_c1r2:Sprite = null;
      
      public var carrierBg_c1r3:Sprite = null;
      
      public var carrierBg_c1r4:Sprite = null;
      
      public var carrierBg_c1r5:Sprite = null;
      
      public var carrierBg_c1r6:Sprite = null;
      
      public var carrierBg_c1r7:Sprite = null;
      
      public var carrierBg_c1r8:Sprite = null;
      
      public var carrierBg_c1r9:Sprite = null;
      
      public var carrierBg_c1r10:Sprite = null;
      
      public var carrierBg_c1r11:Sprite = null;
      
      public var carrierBg_c1r12:Sprite = null;
      
      public var carrierBg_c1r13:Sprite = null;
      
      public var carrierBg_c1r14:Sprite = null;
      
      public var carrierBg_c1r15:Sprite = null;
      
      public var carrierBg_c2r1:Sprite = null;
      
      public var carrierBg_c2r2:Sprite = null;
      
      public var carrierBg_c2r3:Sprite = null;
      
      public var carrierBg_c2r4:Sprite = null;
      
      public var carrierBg_c2r5:Sprite = null;
      
      public var carrierBg_c2r6:Sprite = null;
      
      public var carrierBg_c2r7:Sprite = null;
      
      public var carrierBg_c2r8:Sprite = null;
      
      public var carrierBg_c2r9:Sprite = null;
      
      public var carrierBg_c2r10:Sprite = null;
      
      public var carrierBg_c2r11:Sprite = null;
      
      public var carrierBg_c2r12:Sprite = null;
      
      public var carrierBg_c2r13:Sprite = null;
      
      public var carrierBg_c2r14:Sprite = null;
      
      public var carrierBg_c2r15:Sprite = null;
      
      public function FullStatsTable()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         this.resurrectTimer_c2r15.dispose();
         this.resurrectTimer_c2r14.dispose();
         this.resurrectTimer_c2r13.dispose();
         this.resurrectTimer_c2r12.dispose();
         this.resurrectTimer_c2r11.dispose();
         this.resurrectTimer_c2r10.dispose();
         this.resurrectTimer_c2r9.dispose();
         this.resurrectTimer_c2r8.dispose();
         this.resurrectTimer_c2r7.dispose();
         this.resurrectTimer_c2r6.dispose();
         this.resurrectTimer_c2r5.dispose();
         this.resurrectTimer_c2r4.dispose();
         this.resurrectTimer_c2r3.dispose();
         this.resurrectTimer_c2r2.dispose();
         this.resurrectTimer_c2r1.dispose();
         this.resurrectTimer_c1r15.dispose();
         this.resurrectTimer_c1r14.dispose();
         this.resurrectTimer_c1r13.dispose();
         this.resurrectTimer_c1r12.dispose();
         this.resurrectTimer_c1r11.dispose();
         this.resurrectTimer_c1r10.dispose();
         this.resurrectTimer_c1r9.dispose();
         this.resurrectTimer_c1r8.dispose();
         this.resurrectTimer_c1r7.dispose();
         this.resurrectTimer_c1r6.dispose();
         this.resurrectTimer_c1r5.dispose();
         this.resurrectTimer_c1r4.dispose();
         this.resurrectTimer_c1r3.dispose();
         this.resurrectTimer_c1r2.dispose();
         this.resurrectTimer_c1r1.dispose();
         this.carrierBg_c2r15 = null;
         this.carrierBg_c2r14 = null;
         this.carrierBg_c2r13 = null;
         this.carrierBg_c2r12 = null;
         this.carrierBg_c2r11 = null;
         this.carrierBg_c2r10 = null;
         this.carrierBg_c2r9 = null;
         this.carrierBg_c2r8 = null;
         this.carrierBg_c2r7 = null;
         this.carrierBg_c2r6 = null;
         this.carrierBg_c2r5 = null;
         this.carrierBg_c2r4 = null;
         this.carrierBg_c2r3 = null;
         this.carrierBg_c2r2 = null;
         this.carrierBg_c2r1 = null;
         this.carrierBg_c1r15 = null;
         this.carrierBg_c1r14 = null;
         this.carrierBg_c1r13 = null;
         this.carrierBg_c1r12 = null;
         this.carrierBg_c1r11 = null;
         this.carrierBg_c1r10 = null;
         this.carrierBg_c1r9 = null;
         this.carrierBg_c1r8 = null;
         this.carrierBg_c1r7 = null;
         this.carrierBg_c1r6 = null;
         this.carrierBg_c1r5 = null;
         this.carrierBg_c1r4 = null;
         this.carrierBg_c1r3 = null;
         this.carrierBg_c1r2 = null;
         this.carrierBg_c1r1 = null;
         this.resurrectTimer_c2r15 = null;
         this.resurrectTimer_c2r14 = null;
         this.resurrectTimer_c2r13 = null;
         this.resurrectTimer_c2r12 = null;
         this.resurrectTimer_c2r11 = null;
         this.resurrectTimer_c2r10 = null;
         this.resurrectTimer_c2r9 = null;
         this.resurrectTimer_c2r8 = null;
         this.resurrectTimer_c2r7 = null;
         this.resurrectTimer_c2r6 = null;
         this.resurrectTimer_c2r5 = null;
         this.resurrectTimer_c2r4 = null;
         this.resurrectTimer_c2r3 = null;
         this.resurrectTimer_c2r2 = null;
         this.resurrectTimer_c2r1 = null;
         this.resurrectTimer_c1r15 = null;
         this.resurrectTimer_c1r14 = null;
         this.resurrectTimer_c1r13 = null;
         this.resurrectTimer_c1r12 = null;
         this.resurrectTimer_c1r11 = null;
         this.resurrectTimer_c1r10 = null;
         this.resurrectTimer_c1r9 = null;
         this.resurrectTimer_c1r8 = null;
         this.resurrectTimer_c1r7 = null;
         this.resurrectTimer_c1r6 = null;
         this.resurrectTimer_c1r5 = null;
         this.resurrectTimer_c1r4 = null;
         this.resurrectTimer_c1r3 = null;
         this.resurrectTimer_c1r2 = null;
         this.resurrectTimer_c1r1 = null;
         super.onDispose();
      }
      
      override protected function setTableImages() : void
      {
         background.imageName = BATTLEATLAS.EVENT_STATS_TABLE_BG;
         leftFrag.imageName = BATTLEATLAS.EVENT_STATS_TABLE_FRAGS;
         leftPlatoon.imageName = BATTLEATLAS.STATS_TABLE_PLATOON;
         App.utils.commons.flipHorizontal(leftFrag);
         rightFrag.imageName = BATTLEATLAS.EVENT_STATS_TABLE_FRAGS;
         rightPlatoon.imageName = BATTLEATLAS.STATS_TABLE_PLATOON;
      }
   }
}
