package net.wg.gui.battle.commanderBootcamp.views
{
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import net.wg.data.constants.InvalidationType;
   import net.wg.gui.battle.commander.views.spawnMenu.events.EntryEvent;
   import net.wg.gui.battle.commanderBootcamp.views.spawnMenu.tutorial.TutorialHint;
   import net.wg.gui.battle.commanderBootcamp.views.spawnMenu.tutorial.constants.Directions;
   import net.wg.gui.battle.commanderBootcamp.views.spawnMenu.tutorial.vo.TutorialHintVO;
   import net.wg.infrastructure.base.meta.IBCCommanderSpawnMenuMeta;
   import net.wg.infrastructure.base.meta.impl.BCCommanderSpawnMenuMeta;
   
   public class BCCommanderSpawnMenu extends BCCommanderSpawnMenuMeta implements IBCCommanderSpawnMenuMeta
   {
      
      private static const FOOTER_OFFSET:uint = 50;
      
      private static const AUTO_BUTTON_HINT_X_OFFSET:int = -13;
      
      private static const AUTO_BUTTON_HINT_Y_OFFSET:int = -12;
       
      
      public var footerBCHintTF:TextField = null;
      
      public var autoSetBtnHint:TutorialHint = null;
      
      public function BCCommanderSpawnMenu()
      {
         super();
         this.autoSetBtnHint.mouseEnabled = this.autoSetBtnHint.mouseChildren = false;
      }
      
      override protected function onDispose() : void
      {
         this.footerBCHintTF = null;
         this.autoSetBtnHint.dispose();
         this.autoSetBtnHint = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.SIZE | InvalidationType.POSITION))
         {
            this.autoSetBtnHint.x = left.x + left.mapButtons.x + left.mapButtons.autoSetBtn.x + AUTO_BUTTON_HINT_X_OFFSET;
            this.autoSetBtnHint.y = left.y + left.mapButtons.y + left.mapButtons.autoSetBtn.y + AUTO_BUTTON_HINT_Y_OFFSET;
            this.footerBCHintTF.y = footer.y + footer.height + FOOTER_OFFSET;
            this.autoSetBtnHint.setSize(left.mapButtons.autoSetBtn.width,left.mapButtons.autoSetBtn.height);
         }
      }
      
      public function as_setEnemyNameVisibility(param1:Boolean) : void
      {
         right.setEnemyNameVisibility(param1);
      }
      
      public function as_showButtonArrowHint(param1:Boolean, param2:String) : void
      {
         if(param1)
         {
            this.autoSetBtnHint.model = new TutorialHintVO({
               "hasBox":true,
               "hasArrow":true,
               "arrowLoop":true,
               "hintText":param2,
               "arrowDir":Directions.BOTTOM,
               "positionValue":0.5,
               "padding":{
                  "left":0,
                  "right":0,
                  "top":0,
                  "bottom":0
               }
            });
            this.autoSetBtnHint.show();
            this.autoSetBtnHint.visible = param1;
         }
         else
         {
            this.autoSetBtnHint.hide();
         }
      }
      
      public function as_showFooterHintText(param1:Boolean, param2:String) : void
      {
         this.footerBCHintTF.visible = param1;
         this.footerBCHintTF.text = param2;
      }
      
      override protected function isBGClicked(param1:MouseEvent) : Boolean
      {
         return false;
      }
      
      override protected function processEntryEvent(param1:EntryEvent) : void
      {
      }
      
      override protected function processMapClickEvent(param1:MouseEvent) : void
      {
      }
   }
}
