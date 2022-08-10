package net.wg.gui.messenger.windows
{
   import net.wg.gui.components.advanced.TextAreaSimple;
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.infrastructure.base.UIComponentEx;
   import scaleform.clik.constants.ConstrainMode;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.utils.Constraints;
   
   public class PMWarningPanel extends UIComponentEx
   {
      
      private static const MSG_TA:String = "msgTA";
      
      private static const CLOSE_WARNING_BTN:String = "closeWarningBtn";
       
      
      public var msgTA:TextAreaSimple;
      
      public var closeWarningBtn:SoundButtonEx;
      
      private var _warningStr:String;
      
      public function PMWarningPanel()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         constraints = new Constraints(this,ConstrainMode.REFLOW);
         constraints.addElement(MSG_TA,this.msgTA,Constraints.LEFT | Constraints.TOP | Constraints.RIGHT);
         constraints.addElement(CLOSE_WARNING_BTN,this.closeWarningBtn,Constraints.RIGHT | Constraints.BOTTOM);
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(MSG_TA))
         {
            this.msgTA.htmlText = this._warningStr;
         }
         if(constraints && isInvalid(InvalidationType.SIZE))
         {
            constraints.update(_width,_height);
         }
      }
      
      override protected function onDispose() : void
      {
         this.msgTA.dispose();
         this.msgTA = null;
         this.closeWarningBtn = null;
         super.onDispose();
      }
      
      public function setWarning(param1:String) : void
      {
         this._warningStr = param1;
         invalidate(MSG_TA);
      }
   }
}
