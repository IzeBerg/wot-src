package net.wg.gui.lobby.missions.components
{
   import net.wg.gui.lobby.missions.components.headerComponents.HeaderTitleBlockBase;
   import net.wg.gui.lobby.missions.data.MissionPackHeaderBaseVO;
   import net.wg.gui.lobby.missions.interfaces.IMissionPackHeader;
   import net.wg.infrastructure.base.UIComponentEx;
   import scaleform.clik.constants.InvalidationType;
   
   public class MissionPackHeaderBase extends UIComponentEx implements IMissionPackHeader
   {
       
      
      public var titleBlock:HeaderTitleBlockBase;
      
      protected var data:MissionPackHeaderBaseVO;
      
      private var _oldData:Object;
      
      public function MissionPackHeaderBase()
      {
         super();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(this.data && isInvalid(InvalidationType.DATA))
         {
            this.titleBlock.update(this.data.titleBlockVO);
            this.titleBlock.validateNow();
            invalidateSize();
         }
         if(isInvalid(InvalidationType.SIZE))
         {
            this.titleBlock.width = width;
         }
      }
      
      override protected function onDispose() : void
      {
         this.titleBlock.dispose();
         this.titleBlock = null;
         this.data.dispose();
         this.data = null;
         this._oldData = null;
         super.onDispose();
      }
      
      public function setCollapsed(param1:Boolean, param2:Boolean) : void
      {
         this.titleBlock.setCollapsed(param1,param2);
      }
      
      public function update(param1:Object) : void
      {
         if(this._oldData != param1)
         {
            this._oldData = param1;
            this.data = new this.dataClass(param1);
            invalidateData();
         }
      }
      
      protected function get dataClass() : Class
      {
         return MissionPackHeaderBaseVO;
      }
   }
}
