angular.module("mediaPlayer", ["mediaPlayer.helpers"]).constant("playerDefaults", {
    currentTrack: 0,
    ended: void 0,
    network: void 0,
    playing: !1,
    seeking: !1,
    tracks: 0,
    volume: 1,
    formatDuration: "00:00",
    formatTime: "00:00",
    loadPercent: 0
}).directive("mediaPlayer", ["$rootScope", "$interpolate", "$timeout", "throttle", "playerDefaults",
    function(a, b, c, d, e) {
        function f(a) {
            return function(b, d) {
                var e, f = null;
                if (a.$attachPlaylist(b), void 0 === b && void 0 !== d) return a.pause();
                if (a.currentTrack) {
                    e = d ? d[a.currentTrack - 1] : -1;
                    for (var g = 0; g < b.length; g++)
                        if (angular.equals(b[g], e)) {
                            f = g;
                            break
                        }
                    null !== f ? (a.currentTrack = f + 1, a.tracks = b.length) : (a.pause(), b.length ? c(function() {
                        a.$clearSourceList(), a.$addSourceList(b[0]), a.load(), a.tracks = b.length
                    }) : a.reset())
                } else b.length ? (a.$clearSourceList(), a.$addSourceList(b[0]), a.load(), a.tracks = b.length) : a.reset()
            }
        }
        var g = {
            load: function(a, b) {
                "boolean" == typeof a ? (b = a, a = null) : "object" == typeof a && (this.$clearSourceList(), this.$addSourceList(a)), this.$domEl.load(), this.ended = void 0, b && this.$element.one("canplay", this.play.bind(this))
            },
            reset: function(a) {
                angular.extend(this, e), this.$clearSourceList(), this.load(this.$playlist, a)
            },
            play: function(a, b) {
                return "boolean" == typeof a && (b = a, a = void 0), b && (this.$selective = !0), this.$playlist.length > a ? (this.currentTrack = a + 1, this.load(this.$playlist[a], !0)) : (!this.currentTrack && this.$domEl.readyState && this.currentTrack++, void(this.ended ? this.load(!0) : this.$domEl.play()))
            },
            playPause: function(a, b) {
                "boolean" == typeof a && (b = a, a = void 0), b && (this.$autoplay = !0), "number" == typeof a && a + 1 !== this.currentTrack ? this.play(a) : this.playing ? this.pause() : this.play()
            },
            pause: function() {
                this.$domEl.pause()
            },
            stop: function() {
                this.reset()
            },
            toggleMute: function() {
                this.muted = this.$domEl.muted = !this.$domEl.muted
            },
            next: function(a) {
                var b = this;
                if (b.currentTrack && b.currentTrack < b.tracks) {
                    var d = a || b.playing;
                    b.pause(), c(function() {
                        b.$clearSourceList(), b.$addSourceList(b.$playlist[b.currentTrack]), b.load(d), b.currentTrack++
                    })
                }
            },
            prev: function(a) {
                var b = this;
                if (b.currentTrack && b.currentTrack - 1) {
                    var d = a || b.playing;
                    b.pause(), c(function() {
                        b.$clearSourceList(), b.$addSourceList(b.$playlist[b.currentTrack - 2]), b.load(d), b.currentTrack--
                    })
                }
            },
            setPlaybackRate: function(a) {
                this.$domEl.playbackRate = a
            },
            setVolume: function(a) {
                this.$domEl.volume = a
            },
            seek: function(a) {
                var b, c = 0;
                return "string" != typeof a ? this.$domEl.currentTime = a : (b = a.split(":"), c += parseInt(b.pop(), 10), b.length && (c += 60 * parseInt(b.pop(), 10)), b.length && (c += 3600 * parseInt(b.pop(), 10)), isNaN(c) ? void 0 : this.$domEl.currentTime = c)
            },
            on: function(a, b) {
                return this.$element.on(a, b)
            },
            off: function(a, b) {
                return this.$element.off(a, b)
            },
            one: function(a, b) {
                return this.$element.one(a, b)
            },
            $addSourceList: function(a) {
                var b = this;
                if (angular.isArray(a)) angular.forEach(a, function(a) {
                    var c = document.createElement("SOURCE");
                    ["src", "type", "media"].forEach(function(b) {
                        void 0 !== a[b] && c.setAttribute(b, a[b])
                    }), b.$element.append(c)
                });
                else if (angular.isObject(a)) {
                    var c = document.createElement("SOURCE");
                    ["src", "type", "media"].forEach(function(b) {
                        void 0 !== a[b] && c.setAttribute(b, a[b])
                    }), b.$element.append(c)
                }
            },
            $clearSourceList: function() {
                this.$element.contents().remove()
            },
            $formatTime: function(a) {
                if (1 / 0 === a) return "∞";
                var b, c = parseInt(a / 3600, 10) % 24,
                    d = parseInt(a / 60, 10) % 60,
                    e = parseInt(a % 60, 10),
                    f = (10 > d ? "0" + d : d) + ":" + (10 > e ? "0" + e : e);
                return b = c > 0 ? (10 > c ? "0" + c : c) + ":" + f : f
            },
            $attachPlaylist: function(a) {
                void 0 === a || null === a ? this.playlist = [] : this.$playlist = a
            }
        }, h = function(a, b, c) {
                var e = {
                    playing: function() {
                        a.$apply(function(a) {
                            a.playing = !0, a.ended = !1
                        })
                    },
                    pause: function() {
                        a.$apply(function(a) {
                            a.playing = !1
                        })
                    },
                    ended: function() {
                        !a.$selective && a.currentTrack < a.tracks ? a.next(!0) : a.$apply(function(a) {
                            a.ended = !0, a.playing = !1
                        })
                    },
                    timeupdate: d(1e3, !1, function() {
                        a.$apply(function(a) {
                            a.currentTime = b.currentTime, a.formatTime = a.$formatTime(a.currentTime)
                        })
                    }),
                    loadedmetadata: function() {
                        a.$apply(function(a) {
                            a.currentTrack || a.currentTrack++, a.duration = b.duration, a.formatDuration = a.$formatTime(a.duration), b.buffered.length && (a.loadPercent = Math.round(b.buffered.end(b.buffered.length - 1) / a.duration * 100))
                        })
                    },
                    progress: function() {
                        a.$domEl.buffered.length && a.$apply(function(a) {
                            a.loadPercent = Math.round(b.buffered.end(b.buffered.length - 1) / a.duration * 100), a.network = "progress"
                        })
                    },
                    volumechange: function() {
                        a.$apply(function(a) {
                            a.volume = b.volume, a.muted = b.muted
                        })
                    },
                    seeked: function() {
                        a.$apply(function(a) {
                            a.seeking = !1
                        })
                    },
                    seeking: function() {
                        a.$apply(function(a) {
                            a.seeking = !0
                        })
                    },
                    ratechange: function() {
                        a.$apply(function(a) {
                            a.playbackRate = b.playbackRate
                        })
                    },
                    stalled: function() {
                        a.$apply(function(a) {
                            a.network = "stalled"
                        })
                    },
                    suspend: function() {
                        a.$apply(function(a) {
                            a.network = "suspend"
                        })
                    }
                };
                angular.forEach(e, function(a, b) {
                    c.on(b, a)
                })
            }, i = function(b) {
                var c = angular.extend(a.$new(!0), {
                    $element: b,
                    $domEl: b[0],
                    $playlist: void 0,
                    buffered: b[0].buffered,
                    played: b[0].played,
                    seekable: b[0].seekable
                }, e, g);
                return h(c, b[0], b), c
            };
        return {
            scope: !1,
            link: function(a, b, c) {
                var d = c.playlist,
                    e = c.mediaPlayer || c.playerControl,
                    g = new i(b),
                    h = a[d];
                if (h = void 0 === d ? [] : void 0 === a[d] ? a[d] = [] : a[d], void 0 !== e && (a[e] = g), "AUDIO" !== b[0].tagName && "VIDEO" !== b[0].tagName) return new Error("player directive works only when attached to an <audio>/<video> type tag");
                var j = [],
                    k = b.find("source");
                1 === k.length ? h.unshift({
                    src: k[0].src,
                    type: k[0].type,
                    media: k[0].media
                }) : k.length > 1 && (angular.forEach(k, function(a) {
                    j.push({
                        src: a.src,
                        type: a.type,
                        media: a.media
                    })
                }), h.unshift(j)), void 0 === d ? g.$attachPlaylist(h) : h.length ? (f(g)(h, void 0, a), a.$watch(d, f(g), !0)) : a.$watch(d, f(g), !0), a.$on("$destroy", g.$destroy)
            }
        }
    }
]), angular.module("mediaPlayer.helpers", []).factory("throttle", ["$timeout",
    function(a) {
        return function(b, c, d, e) {
            var f, g = 0;
            "boolean" != typeof c && (e = d, d = c, c = void 0);
            var h = function() {
                var h = this,
                    i = +new Date - g,
                    j = arguments,
                    k = function() {
                        g = +new Date, d.apply(h, j)
                    }, l = function() {
                        f = void 0
                    };
                e && !f && k(), f && a.cancel(f), void 0 === e && i > b ? k() : c !== !0 && (f = a(e ? l : k, void 0 === e ? b - i : b))
            };
            return h
        }
    }
]);