package net.wg.gui.battle.views.stats.fullStats
{
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import net.wg.data.constants.Linkages;
   import net.wg.gui.battle.components.BattleUIComponentsHolder;
   import net.wg.gui.components.dogtag.DogtagComponent;
   import net.wg.gui.components.dogtag.VO.DogTagVO;
   
   public class DogTagCtrl extends BattleUIComponentsHolder
   {
       
      
      protected var hitArea:Sprite = null;
      
      private var _dogTag:DogtagComponent = null;
      
      private var _dogTagData:DogTagVO = null;
      
      public function DogTagCtrl(param1:Sprite)
      {
         super();
         this.hitArea = param1;
      }
      
      override protected function onDispose() : void
      {
         this.hitArea.removeEventListener(MouseEvent.ROLL_OVER,this.onHitAreaRollOverHandler);
         this.hitArea.removeEventListener(MouseEvent.ROLL_OUT,this.onHitAreaRollOutHandler);
         this.hitArea = null;
         if(this._dogTag)
         {
            this._dogTag.dispose();
            this._dogTag = null;
         }
         this._dogTagData = null;
         super.onDispose();
      }
      
      public function setDogTag(param1:DogTagVO) : void
      {
         if(!this._dogTag && param1)
         {
            this.buildDogTag();
         }
         if(this._dogTag)
         {
            this.resetDogTag();
         }
         if(param1)
         {
            this._dogTagData = param1;
            this.hitArea.addEventListener(MouseEvent.ROLL_OVER,this.onHitAreaRollOverHandler);
            this.hitArea.addEventListener(MouseEvent.ROLL_OUT,this.onHitAreaRollOutHandler);
         }
      }
      
      private function resetDogTag() : void
      {
         this._dogTag.alpha = 0;
         this._dogTagData = null;
         this.hitArea.removeEventListener(MouseEvent.ROLL_OVER,this.onHitAreaRollOverHandler);
         this.hitArea.removeEventListener(MouseEvent.ROLL_OUT,this.onHitAreaRollOutHandler);
      }
      
      private function buildDogTag() : void
      {
         this._dogTag = App.utils.classFactory.getComponent(Linkages.DOGTAG,DogtagComponent);
         this.hitArea.parent.addChild(this._dogTag);
         this._dogTag.hideNameAndClan();
         this._dogTag.x = this._dogTag.width >> 2;
         this._dogTag.goToLabel(DogtagComponent.DOGTAG_LABEL_END_FULL);
         this._dogTag.alpha = 0;
      }
      
      private function onHitAreaRollOverHandler(param1:MouseEvent) : void
      {
         this._dogTag.setDogTagInfo(this._dogTagData);
         this._dogTag.y = this.hitArea.y + this._dogTag.height >> 1;
         this._dogTag.fadeIn();
      }
      
      private function onHitAreaRollOutHandler(param1:MouseEvent) : void
      {
         this._dogTag.fadeOut();
      }
   }
}
