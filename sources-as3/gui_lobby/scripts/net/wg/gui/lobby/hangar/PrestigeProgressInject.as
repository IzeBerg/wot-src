package net.wg.gui.lobby.hangar
{
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import net.wg.data.constants.Directions;
   import net.wg.infrastructure.base.meta.IPrestigeProgressInjectMeta;
   import net.wg.infrastructure.base.meta.impl.PrestigeProgressInjectMeta;
   import net.wg.utils.helpLayout.HelpLayoutVO;
   import net.wg.utils.helpLayout.IHelpLayoutComponent;
   
   public class PrestigeProgressInject extends PrestigeProgressInjectMeta implements IPrestigeProgressInjectMeta, IHelpLayoutComponent
   {
      
      public static const PRESTIGE_WIDGET_WIDTH:int = 322;
      
      public static const PRESTIGE_WIDGET_HEIGHT:int = 74;
      
      public static const PRESTIGE_WIDGET_HEIGHT_SMALL:int = 58;
      
      public static const PRESTIGE_WIDGET_OFFSET:uint = 2;
      
      public static const PRESTIGE_WIDGET_NAME:String = "prestigeProgressWidget";
      
      private static const HELP_LAYOUT_ID_DELIMITER:String = "_";
      
      private static const HELP_LAYOUT_WIDTH:int = 343;
       
      
      public var bg:Sprite = null;
      
      private var _helpLayoutId:String = "";
      
      public function PrestigeProgressInject()
      {
         super();
         setManageSize(true);
      }
      
      override public function setSize(param1:Number, param2:Number) : void
      {
         super.setSize(param1,param2);
         if(this.bg)
         {
            this.bg.height = param2 - 2 * PrestigeProgressInject.PRESTIGE_WIDGET_OFFSET;
         }
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         App.utils.helpLayout.registerComponent(this);
         if(this.bg)
         {
            this.bg.visible = false;
         }
         addEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler);
         addEventListener(MouseEvent.ROLL_OUT,this.onRollOutHandler);
      }
      
      override protected function onDispose() : void
      {
         removeEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler);
         removeEventListener(MouseEvent.ROLL_OUT,this.onRollOutHandler);
         if(this.bg)
         {
            this.bg = null;
         }
         super.onDispose();
      }
      
      public function getLayoutProperties() : Vector.<HelpLayoutVO>
      {
         if(!this._helpLayoutId)
         {
            this._helpLayoutId = name + HELP_LAYOUT_ID_DELIMITER + Math.random();
         }
         var _loc1_:int = Hangar.getAdditionalHelpLayoutOffset();
         var _loc2_:HelpLayoutVO = new HelpLayoutVO();
         _loc2_.x = actualWidth - HELP_LAYOUT_WIDTH - 1 - _loc1_;
         _loc2_.y = 0;
         _loc2_.width = HELP_LAYOUT_WIDTH + _loc1_;
         _loc2_.height = actualHeight;
         _loc2_.extensibilityDirection = Directions.RIGHT;
         _loc2_.message = LOBBY_HELP.HANGAR_PRESTIGE;
         _loc2_.id = this._helpLayoutId;
         _loc2_.scope = this;
         return new <HelpLayoutVO>[_loc2_];
      }
      
      private function onRollOutHandler(param1:MouseEvent) : void
      {
         if(this.bg)
         {
            this.bg.visible = false;
         }
      }
      
      private function onRollOverHandler(param1:MouseEvent) : void
      {
         if(this.bg)
         {
            this.bg.visible = true;
         }
      }
   }
}
