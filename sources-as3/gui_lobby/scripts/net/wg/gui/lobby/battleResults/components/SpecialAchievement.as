package net.wg.gui.lobby.battleResults.components
{
   import flash.display.MovieClip;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.gui.lobby.battleResults.data.BattleResultsMedalsListVO;
   import net.wg.infrastructure.base.UIComponentEx;
   import scaleform.clik.constants.InvalidationType;
   
   public class SpecialAchievement extends UIComponentEx
   {
       
      
      public var stripe:MovieClip;
      
      public var loader:UILoaderAlt;
      
      private var _data:BattleResultsMedalsListVO;
      
      public function SpecialAchievement()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.stripe.visible = this.loader.visible = false;
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.DATA) && this._data)
         {
            if(this._data.isEpic)
            {
               this.stripe.visible = true;
            }
            else if(this._data.specialIcon)
            {
               this.loader.visible = true;
               this.loader.source = this._data.specialIcon;
            }
            else
            {
               this.stripe.visible = this.loader.visible = false;
            }
         }
      }
      
      public function set data(param1:Object) : void
      {
         this._data = BattleResultsMedalsListVO(param1);
         invalidateData();
      }
      
      override protected function onDispose() : void
      {
         this.stripe = null;
         this.loader.dispose();
         this.loader = null;
         this._data = null;
         super.onDispose();
      }
   }
}
