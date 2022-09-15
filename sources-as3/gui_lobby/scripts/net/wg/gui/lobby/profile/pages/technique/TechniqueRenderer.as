package net.wg.gui.lobby.profile.pages.technique
{
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import net.wg.data.constants.Values;
   import net.wg.data.constants.generated.CONTEXT_MENU_HANDLER_TYPE;
   import net.wg.gui.components.controls.SoundListItemRenderer;
   import net.wg.gui.lobby.profile.components.TechMasteryIcon;
   import net.wg.gui.lobby.profile.pages.technique.data.TechniqueListVehicleVO;
   import net.wg.infrastructure.interfaces.IImage;
   import scaleform.clik.constants.InvalidationType;
   
   public class TechniqueRenderer extends SoundListItemRenderer
   {
      
      private static const FILE_EXTENSION:String = ".png";
       
      
      public var vehicleTF:TextField = null;
      
      public var battlesTF:TextField = null;
      
      public var winsTF:TextField = null;
      
      public var avgExpTF:TextField = null;
      
      public var nationIcon:IImage = null;
      
      public var typeIcon:IImage = null;
      
      public var masteryIcon:TechMasteryIcon = null;
      
      public var levelMC:MovieClip = null;
      
      public var background:MovieClip = null;
      
      public var hit:MovieClip = null;
      
      public var tankIcon:IImage = null;
      
      public var prestigePointsTF:TextField = null;
      
      private var _compareModeAvailable:Boolean = false;
      
      public function TechniqueRenderer()
      {
         super();
      }
      
      private static function getSmallMasteryIconPath(param1:int) : String
      {
         if(param1 > 0)
         {
            return RES_ICONS.maps_icons_library_proficiency_class_icons(param1 + FILE_EXTENSION);
         }
         return null;
      }
      
      private static function getString(param1:Number) : String
      {
         if(App.utils)
         {
            return App.utils.locale.integer(param1);
         }
         return param1.toString();
      }
      
      override public function setData(param1:Object) : void
      {
         if(_baseDisposed)
         {
            return;
         }
         this.data = param1;
         invalidateData();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         addEventListener(MouseEvent.MOUSE_DOWN,this.onMouseDownHandler);
         this.mouseChildren = true;
         this.masteryIcon.mouseChildren = false;
         this.masteryIcon.buttonMode = true;
         buttonMode = true;
         hitArea = this.hit;
      }
      
      override protected function draw() : void
      {
         var _loc1_:Boolean = false;
         var _loc2_:DisplayObject = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:TechniqueListVehicleVO = null;
         var _loc6_:int = 0;
         var _loc7_:String = null;
         var _loc8_:Boolean = false;
         if(_baseDisposed)
         {
            return;
         }
         super.draw();
         if(isInvalid(InvalidationType.DATA))
         {
            _loc1_ = false;
            this.masteryIcon.visible = false;
            if(data)
            {
               _loc1_ = true;
               _loc5_ = TechniqueListVehicleVO(data);
               this._compareModeAvailable = _loc5_.compareModeAvailable;
               this.vehicleTF.htmlText = _loc5_.shortUserName;
               this.battlesTF.text = getString(_loc5_.battlesCount);
               this.winsTF.text = _loc5_.winsEfficiencyStr;
               _loc6_ = _loc5_.avgExperience;
               this.avgExpTF.text = _loc6_ == 0 ? Values.EMPTY_STR : getString(_loc6_);
               this.nationIcon.source = _loc5_.nationIconPath;
               this.typeIcon.source = _loc5_.typeIconPath;
               this.tankIcon.source = _loc5_.tankIconPath;
               _loc7_ = getSmallMasteryIconPath(_loc5_.markOfMastery);
               if(_loc7_)
               {
                  this.masteryIcon.source = _loc7_;
                  this.masteryIcon.visible = true;
               }
               this.masteryIcon.data = _loc5_;
               this.levelMC.gotoAndStop(_loc5_.level);
               _loc8_ = _loc5_.prestigePoints > Values.DEFAULT_INT;
               this.prestigePointsTF.visible = _loc8_;
               if(_loc8_)
               {
                  this.prestigePointsTF.text = getString(_loc5_.prestigePoints);
               }
            }
            _loc3_ = numChildren;
            _loc4_ = 0;
            while(_loc4_ < _loc3_)
            {
               _loc2_ = getChildAt(_loc4_);
               if(_loc2_ != this.background && _loc2_ != this.masteryIcon)
               {
                  _loc2_.visible = _loc1_;
               }
               _loc4_++;
            }
         }
      }
      
      override protected function onDispose() : void
      {
         removeEventListener(MouseEvent.MOUSE_DOWN,this.onMouseDownHandler);
         this.nationIcon.dispose();
         this.nationIcon = null;
         this.typeIcon.dispose();
         this.typeIcon = null;
         this.masteryIcon.dispose();
         this.masteryIcon = null;
         this.tankIcon.dispose();
         this.tankIcon = null;
         this.vehicleTF = null;
         this.battlesTF = null;
         this.winsTF = null;
         this.avgExpTF = null;
         this.prestigePointsTF = null;
         this.levelMC = null;
         this.background = null;
         this.hit = null;
         super.onDispose();
      }
      
      override public function set mouseChildren(param1:Boolean) : void
      {
         super.mouseChildren = true;
      }
      
      private function onMouseDownHandler(param1:MouseEvent) : void
      {
         if(this._compareModeAvailable && App.utils.commons.isRightButton(param1))
         {
            App.contextMenuMgr.show(CONTEXT_MENU_HANDLER_TYPE.PROFILE_VEHICLE,this,{"id":TechniqueListVehicleVO(data).id});
         }
      }
   }
}
