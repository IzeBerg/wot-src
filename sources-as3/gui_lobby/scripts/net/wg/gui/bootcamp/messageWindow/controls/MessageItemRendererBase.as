package net.wg.gui.bootcamp.messageWindow.controls
{
   import flash.text.TextField;
   import net.wg.gui.bootcamp.messageWindow.data.MessageBottomItemVO;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.infrastructure.interfaces.entity.IUpdatable;
   import scaleform.clik.constants.InvalidationType;
   
   public class MessageItemRendererBase extends UIComponentEx implements IUpdatable
   {
       
      
      public var textField:TextField = null;
      
      private var _data:MessageBottomItemVO;
      
      public function MessageItemRendererBase()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         this.textField = null;
         this._data = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.DATA))
         {
            this.updateData();
         }
      }
      
      public function update(param1:Object) : void
      {
         this._data = MessageBottomItemVO(param1);
         invalidateData();
      }
      
      protected function updateData() : void
      {
         this.textField.text = this._data.label;
      }
      
      protected function get data() : MessageBottomItemVO
      {
         return this._data;
      }
   }
}
