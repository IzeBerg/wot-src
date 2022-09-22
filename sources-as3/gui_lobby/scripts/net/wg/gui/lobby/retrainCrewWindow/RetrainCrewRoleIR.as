package net.wg.gui.lobby.retrainCrewWindow
{
   import flash.events.MouseEvent;
   import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.infrastructure.interfaces.entity.IUpdatable;
   import scaleform.clik.constants.InvalidationType;
   
   public class RetrainCrewRoleIR extends UIComponentEx implements IUpdatable
   {
       
      
      public var loader:UILoaderAlt;
      
      private var _data:RetrainTankmanVO;
      
      public function RetrainCrewRoleIR()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         addEventListener(MouseEvent.MOUSE_OVER,this.onMouseOverHandler,false,0,true);
         addEventListener(MouseEvent.MOUSE_OUT,this.onMouseOutHandler,false,0,true);
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(this._data && isInvalid(InvalidationType.DATA))
         {
            this.loader.source = this._data.iconPath;
         }
      }
      
      override protected function onDispose() : void
      {
         removeEventListener(MouseEvent.MOUSE_OVER,this.onMouseOverHandler);
         removeEventListener(MouseEvent.MOUSE_OUT,this.onMouseOutHandler);
         this.loader.dispose();
         this.loader = null;
         this._data = null;
         super.onDispose();
      }
      
      public function update(param1:Object) : void
      {
         this._data = RetrainTankmanVO(param1);
         invalidateData();
      }
      
      private function onMouseOutHandler(param1:MouseEvent) : void
      {
         App.toolTipMgr.hide();
      }
      
      private function onMouseOverHandler(param1:MouseEvent) : void
      {
         App.toolTipMgr.showSpecial(TOOLTIPS_CONSTANTS.TANKMAN,null,this._data.tankmanID,true);
      }
   }
}
