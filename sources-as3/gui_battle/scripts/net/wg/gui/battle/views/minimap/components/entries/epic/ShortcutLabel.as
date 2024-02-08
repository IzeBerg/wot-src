package net.wg.gui.battle.views.minimap.components.entries.epic
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.data.constants.InvalidationType;
   import net.wg.gui.battle.components.BattleUIComponent;
   
   public class ShortcutLabel extends BattleUIComponent
   {
      
      private static const MIN_BG_WIDTH:int = 32;
      
      private static const LABEL_SPACING:int = 8;
       
      
      public var mapBtnTF:TextField = null;
      
      public var background:MovieClip = null;
      
      private var _label:String = null;
      
      public function ShortcutLabel()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.mapBtnTF.autoSize = TextFieldAutoSize.CENTER;
      }
      
      override protected function onDispose() : void
      {
         this.mapBtnTF = null;
         this.background = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.DATA))
         {
            this.mapBtnTF.text = this._label;
            this.background.width = Math.max(MIN_BG_WIDTH,this.mapBtnTF.width + LABEL_SPACING) >> 0;
            this.background.x = -this.background.width;
            this.mapBtnTF.x = -(this.mapBtnTF.width + (this.background.width - this.mapBtnTF.width) / 2) >> 0;
         }
      }
      
      public function set label(param1:String) : void
      {
         this._label = param1;
         this.invalidateData();
      }
   }
}
