package net.wg.gui.battle.commander.views.common
{
   import flash.text.TextField;
   import net.wg.data.constants.InvalidationType;
   
   public class GroupIcon extends BaseIcon
   {
      
      private static const FRAME_SELECTED:String = "selected";
      
      private static const FRAME_NORMAL:String = "normal";
       
      
      public var textTF:TextField = null;
      
      private var _groupID:int = 0;
      
      private var _isSelected:Boolean = false;
      
      public function GroupIcon()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         this.textTF = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.DATA))
         {
            visible = isShown && isAlive && this.groupID > 0;
            if(visible)
            {
               gotoAndStop(!!this.isSelected ? FRAME_SELECTED : FRAME_NORMAL);
               this.textTF.text = this.groupID.toString();
            }
         }
      }
      
      public function set isSelected(param1:Boolean) : void
      {
         if(this._isSelected != param1)
         {
            this._isSelected = param1;
            invalidateData();
         }
      }
      
      public function get isSelected() : Boolean
      {
         return this._isSelected;
      }
      
      public function set groupID(param1:Number) : void
      {
         if(this._groupID != param1)
         {
            this._groupID = param1;
            invalidateData();
         }
      }
      
      public function get groupID() : Number
      {
         return this._groupID;
      }
   }
}
