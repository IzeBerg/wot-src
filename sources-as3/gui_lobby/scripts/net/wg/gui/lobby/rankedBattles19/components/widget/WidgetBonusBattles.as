package net.wg.gui.lobby.rankedBattles19.components.widget
{
   import flash.text.TextFieldAutoSize;
   import net.wg.gui.lobby.rankedBattles19.components.BonusBattles;
   import net.wg.infrastructure.base.UIComponentEx;
   
   public class WidgetBonusBattles extends UIComponentEx
   {
      
      private static const IDLE_ANIM_LABEL:String = "idle";
      
      private static const SHOW_ANIM_LABEL:String = "show";
      
      private static const HIDE_ANIM_LABEL:String = "hide";
       
      
      public var bonusBattles:BonusBattles = null;
      
      private var _isShow:Boolean = false;
      
      private var _isHide:Boolean = false;
      
      public function WidgetBonusBattles()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.bonusBattles.iconAlign = TextFieldAutoSize.LEFT;
      }
      
      override protected function onDispose() : void
      {
         this.bonusBattles.dispose();
         this.bonusBattles = null;
         super.onDispose();
      }
      
      public function hide() : void
      {
         if(!this._isHide)
         {
            this._isHide = true;
            gotoAndPlay(HIDE_ANIM_LABEL);
         }
      }
      
      public function setText(param1:String) : void
      {
         this._isShow = this._isHide = false;
         this.bonusBattles.setText(param1);
         gotoAndStop(IDLE_ANIM_LABEL);
      }
      
      public function show() : void
      {
         if(!this._isShow)
         {
            this._isShow = true;
            gotoAndPlay(SHOW_ANIM_LABEL);
         }
      }
   }
}
