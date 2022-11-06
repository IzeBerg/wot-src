package net.wg.gui.battle.views.roleDescription
{
   import flash.events.Event;
   import flash.text.TextField;
   import net.wg.data.constants.InvalidationType;
   import net.wg.gui.battle.components.BattleUIComponent;
   import net.wg.gui.battle.views.roleDescription.data.RoleActionVO;
   import net.wg.gui.components.controls.Image;
   
   public class RoleAction extends BattleUIComponent
   {
      
      public static const WIDTH:int = 194;
      
      public static const HEIGHT:int = 164;
      
      private static const DESCRIPTION_Y_OFFSET:int = -28;
       
      
      public var image:Image = null;
      
      public var description:TextField = null;
      
      private var _data:RoleActionVO = null;
      
      public function RoleAction()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.image.addEventListener(Event.CHANGE,this.onImageChangeHandler);
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(this._data != null)
         {
            if(isInvalid(InvalidationType.DATA))
            {
               this.image.source = this._data.image;
               this.description.text = this._data.description;
               App.utils.commons.updateTextFieldSize(this.description,false,true);
            }
            if(isInvalid(InvalidationType.SIZE))
            {
               this.image.x = -this.image.width >> 1;
               this.description.x = -this.description.width >> 1;
               this.description.y = this.image.height + DESCRIPTION_Y_OFFSET | 0;
            }
         }
      }
      
      override protected function onDispose() : void
      {
         this.image.removeEventListener(Event.CHANGE,this.onImageChangeHandler);
         this.image.dispose();
         this.image = null;
         this.description = null;
         this._data = null;
         super.onDispose();
      }
      
      public function setData(param1:RoleActionVO) : void
      {
         if(this._data != param1 && param1 != null)
         {
            this._data = param1;
            invalidateData();
         }
      }
      
      private function onImageChangeHandler(param1:Event) : void
      {
         invalidateSize();
      }
   }
}
