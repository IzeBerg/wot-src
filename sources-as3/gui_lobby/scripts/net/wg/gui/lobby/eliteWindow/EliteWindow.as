package net.wg.gui.lobby.eliteWindow
{
   import flash.display.InteractiveObject;
   import flash.text.TextField;
   import net.wg.data.constants.SoundTypes;
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.gui.rally.vo.VehicleVO;
   import net.wg.infrastructure.base.meta.IEliteWindowMeta;
   import net.wg.infrastructure.base.meta.impl.EliteWindowMeta;
   import scaleform.clik.events.ButtonEvent;
   import scaleform.clik.utils.Constraints;
   
   public class EliteWindow extends EliteWindowMeta implements IEliteWindowMeta
   {
       
      
      public var icon:UILoaderAlt;
      
      public var titleTF:TextField;
      
      public var infoTF:TextField;
      
      public var closeBtn:SoundButtonEx;
      
      private var vName:String = "";
      
      private var vType:String = "";
      
      private const INVALIDATE_TANK_DATA:String = "invTankData";
      
      public function EliteWindow()
      {
         super();
      }
      
      override protected function onPopulate() : void
      {
         super.onPopulate();
         window.useBottomBtns = true;
         window.title = DIALOGS.ELITE_TITLE;
      }
      
      override protected function onDispose() : void
      {
         this.icon.dispose();
         this.closeBtn.removeEventListener(ButtonEvent.CLICK,this.onClose);
         this.closeBtn.dispose();
         this.closeBtn = null;
         if(constraints)
         {
            constraints.removeAllElements();
            constraints = null;
         }
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         constraints = new Constraints(this);
         this.infoTF.text = DIALOGS.ELITE_MESSAGE;
         this.closeBtn.label = DIALOGS.ELITE_CANCEL;
         this.closeBtn.soundType = SoundTypes.CANCEL_BTN;
         this.closeBtn.addEventListener(ButtonEvent.CLICK,this.onClose);
         constraints.addElement("closeBtn",this.closeBtn,Constraints.CENTER_H);
      }
      
      override protected function setVehicle(param1:VehicleVO) : void
      {
         this.vName = param1.userName;
         this.vType = param1.type;
         this.closeBtn.soundType = SoundTypes.CANCEL_BTN;
         invalidate(this.INVALIDATE_TANK_DATA);
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(this.INVALIDATE_TANK_DATA))
         {
            if(this.vType && this.vType.length > 0)
            {
               this.icon.source = "../maps/icons/elitewindow/" + this.vType + ".png";
            }
            if(this.vName && this.vName.length > 0)
            {
               this.titleTF.text = App.utils.locale.makeString(DIALOGS.ELITE_HEADER,{"name":this.vName});
            }
         }
      }
      
      override protected function onInitModalFocus(param1:InteractiveObject) : void
      {
         super.onInitModalFocus(param1);
         setFocus(this.closeBtn);
      }
      
      private function onClose(param1:ButtonEvent) : void
      {
         onWindowCloseS();
      }
   }
}
