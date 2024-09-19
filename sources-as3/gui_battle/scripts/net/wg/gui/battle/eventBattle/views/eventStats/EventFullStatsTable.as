package net.wg.gui.battle.eventBattle.views.eventStats
{
   import flash.display.Sprite;
   import net.wg.data.constants.generated.BATTLEATLAS;
   import net.wg.gui.battle.eventBattle.views.eventPlayersPanel.comps.EventHunterResurrectTimer;
   import net.wg.gui.battle.random.views.stats.components.fullStats.FullStatsTable;
   
   public class EventFullStatsTable extends FullStatsTable
   {
       
      
      public var resurrectTimer_c1r1:EventHunterResurrectTimer = null;
      
      public var resurrectTimer_c1r2:EventHunterResurrectTimer = null;
      
      public var resurrectTimer_c1r3:EventHunterResurrectTimer = null;
      
      public var resurrectTimer_c1r4:EventHunterResurrectTimer = null;
      
      public var resurrectTimer_c1r5:EventHunterResurrectTimer = null;
      
      public var resurrectTimer_c1r6:EventHunterResurrectTimer = null;
      
      public var resurrectTimer_c1r7:EventHunterResurrectTimer = null;
      
      public var resurrectTimer_c1r8:EventHunterResurrectTimer = null;
      
      public var resurrectTimer_c1r9:EventHunterResurrectTimer = null;
      
      public var resurrectTimer_c1r10:EventHunterResurrectTimer = null;
      
      public var resurrectTimer_c1r11:EventHunterResurrectTimer = null;
      
      public var resurrectTimer_c1r12:EventHunterResurrectTimer = null;
      
      public var resurrectTimer_c1r13:EventHunterResurrectTimer = null;
      
      public var resurrectTimer_c1r14:EventHunterResurrectTimer = null;
      
      public var resurrectTimer_c1r15:EventHunterResurrectTimer = null;
      
      public var resurrectTimer_c2r1:EventHunterResurrectTimer = null;
      
      public var resurrectTimer_c2r2:EventHunterResurrectTimer = null;
      
      public var resurrectTimer_c2r3:EventHunterResurrectTimer = null;
      
      public var resurrectTimer_c2r4:EventHunterResurrectTimer = null;
      
      public var resurrectTimer_c2r5:EventHunterResurrectTimer = null;
      
      public var resurrectTimer_c2r6:EventHunterResurrectTimer = null;
      
      public var resurrectTimer_c2r7:EventHunterResurrectTimer = null;
      
      public var resurrectTimer_c2r8:EventHunterResurrectTimer = null;
      
      public var resurrectTimer_c2r9:EventHunterResurrectTimer = null;
      
      public var resurrectTimer_c2r10:EventHunterResurrectTimer = null;
      
      public var resurrectTimer_c2r11:EventHunterResurrectTimer = null;
      
      public var resurrectTimer_c2r12:EventHunterResurrectTimer = null;
      
      public var resurrectTimer_c2r13:EventHunterResurrectTimer = null;
      
      public var resurrectTimer_c2r14:EventHunterResurrectTimer = null;
      
      public var resurrectTimer_c2r15:EventHunterResurrectTimer = null;
      
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
      
      public function EventFullStatsTable()
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
