package net.wg.gui.lobby.missions.components.headerComponents
{
   import flash.display.Sprite;
   import flash.text.TextField;
   import net.wg.gui.interfaces.ISoundButtonEx;
   import net.wg.gui.lobby.missions.data.MissionHeaderActionVO;
   import net.wg.infrastructure.base.UIComponentEx;
   import scaleform.clik.constants.InvalidationType;
   
   public class MissionHeaderAction extends UIComponentEx
   {
       
      
      public var linkBtn:ISoundButtonEx;
      
      public var textField:TextField;
      
      public var hit:Sprite;
      
      private var _data:MissionHeaderActionVO;
      
      public function MissionHeaderAction()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         buttonMode = useHandCursor = true;
         hitArea = this.hit;
         visible = false;
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(this._data != null && isInvalid(InvalidationType.DATA))
         {
            this.textField.htmlText = this._data.label;
            visible = this._data.visible;
         }
      }
      
      override protected function onDispose() : void
      {
         this.linkBtn.dispose();
         this.linkBtn = null;
         this.textField = null;
         this.hit = null;
         this._data = null;
         super.onDispose();
      }
      
      public function getActionId() : String
      {
         return this._data != null ? this._data.actionID : null;
      }
      
      public function setData(param1:MissionHeaderActionVO) : void
      {
         if(this._data != param1)
         {
            this._data = param1;
            if(this._data != null)
            {
               invalidateData();
            }
            else
            {
               visible = false;
            }
         }
      }
   }
}
