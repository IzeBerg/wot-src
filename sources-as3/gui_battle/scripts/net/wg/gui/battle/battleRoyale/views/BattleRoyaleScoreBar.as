package net.wg.gui.battle.battleRoyale.views
{
   import flash.display.BlendMode;
   import flash.display.Sprite;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.data.constants.InvalidationType;
   import net.wg.infrastructure.base.meta.IFragPanelMeta;
   import net.wg.infrastructure.base.meta.impl.FragPanelMeta;
   
   public class BattleRoyaleScoreBar extends FragPanelMeta implements IFragPanelMeta
   {
      
      private static const ICON_TEXT_GAP:int = 10;
      
      private static const SCORE_GAP:int = 18;
       
      
      public var fragIcon:Sprite = null;
      
      public var enemyIcon:Sprite = null;
      
      public var separatorIcon:Sprite = null;
      
      public var fragsField:TextField = null;
      
      public var enemiesField:TextField = null;
      
      public var background:Sprite = null;
      
      public function BattleRoyaleScoreBar()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.fragsField.autoSize = this.enemiesField.autoSize = TextFieldAutoSize.LEFT;
         this.fragsField.blendMode = this.enemiesField.blendMode = BlendMode.ADD;
      }
      
      override protected function onDispose() : void
      {
         this.fragsField = null;
         this.enemiesField = null;
         this.separatorIcon = null;
         this.fragIcon = null;
         this.enemyIcon = null;
         this.background = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         var _loc1_:int = 0;
         super.draw();
         if(isInvalid(InvalidationType.POSITION))
         {
            _loc1_ = this.enemyIcon.width + ICON_TEXT_GAP + this.enemiesField.width + SCORE_GAP + this.separatorIcon.width + SCORE_GAP + this.fragIcon.width + ICON_TEXT_GAP + this.fragsField.width;
            this.enemyIcon.x = -_loc1_ >> 1;
            this.enemiesField.x = this.enemyIcon.x + this.enemyIcon.width + ICON_TEXT_GAP | 0;
            this.separatorIcon.x = this.enemiesField.x + this.enemiesField.width + SCORE_GAP | 0;
            this.fragIcon.x = this.separatorIcon.x + this.separatorIcon.width + SCORE_GAP | 0;
            this.fragsField.x = this.fragIcon.x + this.fragIcon.width + ICON_TEXT_GAP | 0;
         }
      }
      
      public function as_setLeftField(param1:String) : void
      {
         this.enemiesField.htmlText = param1;
         invalidatePosition();
      }
      
      public function as_setRightField(param1:String) : void
      {
         this.fragsField.htmlText = param1;
         invalidatePosition();
      }
   }
}
