package net.wg.gui.battle.pveBase.views.minimap.entries
{
   import net.wg.gui.battle.components.BattleUIComponent;
   
   public class PveArrowEntry extends BattleUIComponent
   {
      
      private static const ANIMATE:String = "animate";
      
      private static const IDLE:String = "idle";
       
      
      public var top:PveCenterBottomAlignedIcon;
      
      public var bottom:PveCenterBottomAlignedIcon;
      
      public function PveArrowEntry()
      {
         super();
         gotoAndStop(IDLE);
      }
      
      public function setArrow(param1:String, param2:Boolean) : void
      {
         this.top.setIcon(param1);
         this.bottom.setIcon(param1);
         if(param2)
         {
            this.top.flip();
            this.bottom.flip();
         }
      }
      
      public function animate() : void
      {
         gotoAndPlay(ANIMATE);
      }
      
      override protected function onDispose() : void
      {
         this.top.dispose();
         this.top = null;
         this.bottom.dispose();
         this.bottom = null;
         stop();
         super.onDispose();
      }
   }
}
