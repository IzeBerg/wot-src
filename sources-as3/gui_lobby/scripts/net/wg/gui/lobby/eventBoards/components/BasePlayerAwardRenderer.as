package net.wg.gui.lobby.eventBoards.components
{
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import net.wg.data.VO.UserVO;
   import net.wg.data.constants.Values;
   import net.wg.data.constants.generated.CONTEXT_MENU_HANDLER_TYPE;
   import net.wg.gui.components.controls.SoundListItemRenderer;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.gui.lobby.eventBoards.data.BasePlayerAwardRendererVO;
   import net.wg.gui.lobby.eventBoards.events.PlayerRendererEvent;
   import net.wg.infrastructure.interfaces.IUserProps;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.clik.constants.InvalidationType;
   
   public class BasePlayerAwardRenderer extends SoundListItemRenderer
   {
      
      private static const TEXT_FIELD_BOUNDS_WIDTH:Number = 4;
      
      private static const TEXT_FIELD_YPOS:Number = 3;
      
      private static const MIN_NAME_LENGTH:Number = 5;
      
      private static const CUT_SYMBOLS_STR:String = "..";
       
      
      public var positionTF:TextField = null;
      
      public var playerTF:TextField = null;
      
      public var value1TF:TextField = null;
      
      public var value2TF:TextField = null;
      
      public var value3TF:TextField = null;
      
      public var valueTimeTF:TextField = null;
      
      public var playerTFHit:Sprite;
      
      public var specialBackground:DisplayObject = null;
      
      public var placeIcon:UILoaderAlt;
      
      private var _rendererData:BasePlayerAwardRendererVO = null;
      
      public function BasePlayerAwardRenderer()
      {
         super();
      }
      
      override public function getData() : Object
      {
         return this._rendererData;
      }
      
      override public function setData(param1:Object) : void
      {
         if(param1 != null)
         {
            if(this.specialBackground && this.placeIcon)
            {
               this.specialBackground.visible = this.placeIcon.visible = false;
            }
            this._rendererData = BasePlayerAwardRendererVO(param1);
            invalidateData();
         }
      }
      
      override public function set selected(param1:Boolean) : void
      {
         super.selected = param1;
         invalidateData();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         visible = false;
         mouseChildren = true;
         useHandCursor = true;
         addEventListener(MouseEvent.CLICK,this.onRendererClickHandler);
         this.playerTFHit.buttonMode = true;
         this.playerTFHit.addEventListener(MouseEvent.MOUSE_OVER,this.onPlayerOverHandler);
         this.playerTFHit.addEventListener(MouseEvent.MOUSE_OUT,this.onPlayerOutHandler);
         this.value1TF.mouseEnabled = this.value2TF.mouseEnabled = this.value3TF.mouseEnabled = this.positionTF.mouseEnabled = false;
      }
      
      override protected function draw() : void
      {
         var _loc1_:UserVO = null;
         if(this._rendererData && isInvalid(InvalidationType.DATA))
         {
            _loc1_ = this._rendererData.userVO;
            if(_loc1_)
            {
               this.formatPlayerName(this.playerTF,App.utils.commons.getUserProps(_loc1_.userName,_loc1_.clanAbbrev,_loc1_.region,_loc1_.igrType,_loc1_.tags));
            }
            this.positionTF.htmlText = this._rendererData.position.toString();
            this.value1TF.htmlText = this._rendererData.value1;
            this.value2TF.htmlText = this._rendererData.value2;
            this.value3TF.htmlText = this._rendererData.value3;
            visible = true;
            if(StringUtils.isNotEmpty(this._rendererData.valueTime))
            {
               this.valueTimeTF.htmlText = this._rendererData.valueTime;
               this.value2TF.y = TEXT_FIELD_YPOS;
            }
            else
            {
               this.valueTimeTF.visible = false;
            }
            if(this.specialBackground && this.placeIcon)
            {
               if(StringUtils.isNotEmpty(this._rendererData.iconPath))
               {
                  this.placeIcon.source = this._rendererData.iconPath;
                  this.specialBackground.visible = this.placeIcon.visible = true;
                  this.positionTF.visible = false;
               }
               else
               {
                  this.specialBackground.visible = this.placeIcon.visible = false;
               }
            }
         }
         super.draw();
      }
      
      override protected function onDispose() : void
      {
         removeEventListener(MouseEvent.CLICK,this.onRendererClickHandler);
         this.playerTFHit.removeEventListener(MouseEvent.MOUSE_OVER,this.onPlayerOverHandler);
         this.playerTFHit.removeEventListener(MouseEvent.MOUSE_OUT,this.onPlayerOutHandler);
         this.playerTFHit = null;
         this.positionTF = null;
         this.playerTF = null;
         this.value1TF = null;
         this.value2TF = null;
         this.value3TF = null;
         this.valueTimeTF = null;
         if(this.specialBackground)
         {
            this.specialBackground = null;
         }
         if(this.placeIcon)
         {
            this.placeIcon.dispose();
            this.placeIcon = null;
         }
         this._rendererData = null;
         super.onDispose();
      }
      
      private function onRendererClickHandler(param1:MouseEvent) : void
      {
         if(App.utils.commons.isLeftButton(param1))
         {
            dispatchEvent(new PlayerRendererEvent(PlayerRendererEvent.PLAYER_CLICK,this._rendererData.userVO.dbID));
         }
      }
      
      override protected function handleMouseRelease(param1:MouseEvent) : void
      {
         super.handleMouseRelease(param1);
         if(App.utils.commons.isRightButton(param1))
         {
            App.contextMenuMgr.show(CONTEXT_MENU_HANDLER_TYPE.BASE_USER,this,this._rendererData.userVO);
         }
      }
      
      private function onPlayerOverHandler(param1:MouseEvent) : void
      {
         if(this._rendererData.userVO)
         {
            App.toolTipMgr.show(this._rendererData.userVO.fullName);
         }
      }
      
      private function onPlayerOutHandler(param1:MouseEvent) : void
      {
         App.toolTipMgr.hide();
      }
      
      protected function formatPlayerName(param1:TextField, param2:IUserProps) : Boolean
      {
         var _loc13_:int = 0;
         var _loc3_:TextFormat = param1.getTextFormat();
         var _loc4_:Object = _loc3_.size;
         var _loc5_:String = _loc3_.font;
         var _loc6_:String = _loc3_.align;
         var _loc7_:Array = param2.tags;
         var _loc8_:String = Boolean(param2.clanAbbrev) ? param2.clanAbbrev : Values.EMPTY_STR;
         var _loc9_:String = Boolean(param2.region) ? Values.SPACE_STR + param2.region : Values.EMPTY_STR;
         var _loc10_:String = _loc9_ + param2.suffix;
         var _loc11_:String = param2.prefix + param2.userName + _loc8_ + _loc10_;
         var _loc12_:Boolean = false;
         this.applyTextProps(param1,_loc11_,_loc3_,_loc4_,_loc5_,_loc6_);
         if(param1.width < param1.textWidth + TEXT_FIELD_BOUNDS_WIDTH)
         {
            _loc12_ = true;
            _loc11_ = param2.prefix + param2.userName.substr(0,MIN_NAME_LENGTH) + CUT_SYMBOLS_STR + _loc8_ + _loc10_;
            this.applyTextProps(param1,_loc11_,_loc3_,_loc4_,_loc5_,_loc6_);
            if(param1.width >= param1.textWidth + TEXT_FIELD_BOUNDS_WIDTH)
            {
               _loc10_ = _loc8_ + _loc10_;
            }
            _loc13_ = param2.userName.length - 1;
            do
            {
               _loc11_ = param2.prefix + param2.userName.substr(0,_loc13_) + CUT_SYMBOLS_STR + _loc10_;
               this.applyTextProps(param1,_loc11_,_loc3_,_loc4_,_loc5_,_loc6_);
               _loc13_--;
            }
            while(param1.width < param1.textWidth + TEXT_FIELD_BOUNDS_WIDTH && _loc13_ > 0);
            
         }
         if(!isNaN(param2.rgb))
         {
            param1.textColor = param2.rgb;
         }
         return _loc12_;
      }
      
      protected function applyTextProps(param1:TextField, param2:String, param3:TextFormat, param4:Object, param5:String, param6:String) : void
      {
         param1.htmlText = param2;
         param3.size = param4;
         param3.font = param5;
         param3.align = param6;
         param1.setTextFormat(param3);
      }
   }
}
